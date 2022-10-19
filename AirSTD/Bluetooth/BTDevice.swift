import Foundation
import CoreBluetooth

protocol BTDeviceDelegate: class {
    func updateStatusLabel(errorText: String?)
    func updateConnectStatus(success: Bool, error: String?)
}

class BTDevice: NSObject {
    let peripheral: CBPeripheral
    private let manager: CBCentralManager
    private var controlChar: CBCharacteristic?
    private var _control = [UInt8]()

    weak var delegate: BTDeviceDelegate?

    var control: [UInt8] {
        get {
            return _control
        }
        set {
            switch peripheral.state {
            case .connected:
                _control = newValue
                if let char = controlChar {
                    if char.properties.contains(.write) {
                        peripheral.writeValue(Data(control), for: char, type: .withResponse)
                    } else if char.properties.contains(.writeWithoutResponse) {
                        peripheral.writeValue(Data(control), for: char, type: .withoutResponse)
                    }
                }
            case .disconnected, .disconnecting:
                delegate?.updateConnectStatus(success: false, error: LocalizedText(.errorConnect).text)
            default:
                break
            }
            print("manager.state", peripheral.state.rawValue)

        }
    }

    var name: String {
        return peripheral.name ?? "Unknown device"
    }
    var detail: String {
        return peripheral.identifier.description
    }
    private(set) var serial: String?

    init(peripheral: CBPeripheral, manager: CBCentralManager) {
        self.peripheral = peripheral
        self.manager = manager
        super.init()
        self.peripheral.delegate = self
    }

    func connect() {
        manager.connect(peripheral, options: nil)
    }

    func disconnect() {
        manager.cancelPeripheralConnection(peripheral)
    }
}

extension BTDevice {
    // these are called from BTManager, do not call directly

    func connectedCallback() {
        peripheral.discoverServices(BTUUIDs.services)
        delegate?.updateConnectStatus(success: true, error: nil)
    }

    func disconnectedCallback() {
        print("Device: disconnectedCallback")
    }

    func errorCallback(error: Error?) {
        print("Device: error \(String(describing: error))")
        delegate?.updateConnectStatus(success: true, error: "Device: error \(String(describing: error))")
    }
}

extension BTDevice: CBPeripheralDelegate {

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("Device: discovered services", error ?? "without error")
        peripheral.services?.forEach {
            print("     \($0)")
            if BTUUIDs.services.contains($0.uuid) {
                peripheral.discoverCharacteristics(BTUUIDs.cteristics, for: $0)
            } else {
                peripheral.discoverCharacteristics(nil, for: $0)
            }

        }
        print("-------\n")
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("Device: peripheral: didDiscoverCharacteristicsFor service:", service)
        if let error = error {
            print("Device: peripheral: didDiscoverCharacteristicsFor service: ERROR:", error)
        }

        print("Device: peripheral: Found characteristics:")
        service.characteristics?.forEach { characteristic in
            print("     \(characteristic)")

//            typedef NS_OPTIONS(NSUInteger, CBCharacteristicProperties) {
//                CBCharacteristicPropertyBroadcast                                                  = 0x01,
//                CBCharacteristicPropertyRead                                                       = 0x02,
//                CBCharacteristicPropertyWriteWithoutResponse                                       = 0x04,
//                CBCharacteristicPropertyWrite                                                      = 0x08,
//                CBCharacteristicPropertyNotify                                                     = 0x10,
//                CBCharacteristicPropertyIndicate                                                   = 0x20,
//                CBCharacteristicPropertyAuthenticatedSignedWrites                                  = 0x40,
//                CBCharacteristicPropertyExtendedProperties                                         = 0x80,
//                CBCharacteristicPropertyNotifyEncryptionRequired NS_ENUM_AVAILABLE(10_9, 6_0)      = 0x100,
//                CBCharacteristicPropertyIndicateEncryptionRequired NS_ENUM_AVAILABLE(10_9, 6_0)    = 0x200
//            };

            for descriptor in (characteristic.descriptors ?? []) {
                print("Device: peripheral: Found characteristic descriptor:", descriptor)
            }

            if BTUUIDs.cteristics.contains(characteristic.uuid) {
                self.controlChar = characteristic

                // send initial command for connection test
                control = [0xFF]

                if characteristic.properties.contains(.read) {
                    peripheral.readValue(for: characteristic)
                }
            }
        }
        print()
    }

    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        print("Device: peripheral: \(peripheral.identifier) didWriteValueFor: \(characteristic.description)")
        for descriptor in (characteristic.descriptors ?? []) {
            print("Device: peripheral: Found characteristic descriptor: descriptor:", descriptor)
        }
        if let error = error {
            print("Device: peripheral: didWriteValueFor: ERROR:", error)
            if (error as NSError).code == 5 {
                disconnect()
            }
        }

        delegate?.updateStatusLabel(errorText: error?.localizedDescription)
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print("Device: peripheral: \(peripheral.identifier) didUpdateValueFor: \(characteristic.description)")
        if let error = error {
            print("Device: peripheral: didUpdateValueFor: ERROR:", error)
        }
    }
}
