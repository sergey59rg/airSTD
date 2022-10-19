//
//  DeviceInterfaceController.swift
//  AirSTDWatch Extension
//
//  Created by Сергей on 21.09.2022.
//  Copyright © 2022 Sergey Zykov. All rights reserved.
//

import WatchKit
import Foundation
import CoreBluetooth

protocol DeviceInterfaceDelegate: class {
    func setup(device: BTDevice?)
    func disconnect()
}

class DeviceInterfaceController: WKInterfaceController {
    
    @IBOutlet var nameLabel : WKInterfaceLabel!
    @IBOutlet var iconImage : WKInterfaceButton!
    @IBOutlet var plusAllButton : WKInterfaceButton!
    @IBOutlet var minusAllButton : WKInterfaceButton!
    @IBOutlet var plusFrontButton : WKInterfaceButton!
    @IBOutlet var minusFrontButton : WKInterfaceButton!
    @IBOutlet var plusRearButton : WKInterfaceButton!
    @IBOutlet var minusRearButton : WKInterfaceButton!
    
    var deviceConnect = false
    var device: BTDevice? {
        didSet {
            nameLabel.setText(device?.name ?? "AirSTD")
        }
    }
    
    var lastTimeWasConnected = false
    var pingTimer: Timer?
    var gestureTimer:Timer?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
    
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        checkDevice()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any? {
        let context = DeviceInterfaceContext()
        if (segueIdentifier == "Settings") {
            context.object = device
        }
        context.delegate = self
        return context
    }
    
    @IBAction func plusPressGesture(_ sender: WKLongPressGestureRecognizer) {
        print("-->plusPressGesture\(sender)")
    }
    
    @IBAction func minusPressGesture(_ sender: WKLongPressGestureRecognizer) {
        print("-->minusPressGesture\(sender)")
    }
    
    @IBAction func plusAllButtonPressed() {
        print("plusAll")
        if device != nil {
            device?.control = [0, 4, 8, 0xc]
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.device?.control = [1, 5, 9, 0xd]
            }
        }
    }
    
    @IBAction func minusAllButtonPressed() {
        print("minusAll")
        if device != nil {
            device?.control = [2, 6, 0xa, 0xe]
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.device?.control = [3, 7, 0xb, 0xf]
            }
        }
    }
    
    @IBAction func plusFrontButtonPressed() {
        print("plusFront")
        if device != nil {
            device?.control = [0, 4]
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.device?.control = [1, 5]
            }
        }
    }
    
    @IBAction func minusFrontButtonPressed() {
        print("minusFront")
        if device != nil {
            device?.control = [2, 6]
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.device?.control = [3, 7]
            }
        }
    }
    
    @IBAction func plusRearButtonPressed() {
        print("plusRear")
        if device != nil {
            device?.control = [8, 0xc]
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.device?.control = [9, 0xd]
            }
        }
    }
    
    @IBAction func minusRearButtonPressed() {
        print("minusRear")
        if device != nil {
            device?.control = [0xa, 0xe]
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.device?.control = [0xb, 0xf]
            }
        }
    }
    
    @IBAction func iconImagePressed() {
        print("icon")
        if device == nil {
            presentController(withName: "Search", context: contextForSegue(withIdentifier: "Search"))
        } else {
            presentController(withName: "Settings", context: contextForSegue(withIdentifier: "Settings"))
        }
    }
    
}

extension DeviceInterfaceController: BTDeviceDelegate {
    
    func updateConnectStatus(success: Bool, error: String? = nil) {
        lastTimeWasConnected = success
        if success {
            UserDefaults.deviceID = device?.detail
            iconImage.setBackgroundImage(#imageLiteral(resourceName: "ic_gear_green"))
            deviceConnect = true
            startPing()
        } else {
            let closeAction = WKAlertAction(title: LocalizedText(.close).text, style: .cancel) { self.dismiss() }
            presentAlert(withTitle: LocalizedText(.error).text, message: error, preferredStyle: .alert, actions: [closeAction])
            iconImage.setBackgroundImage(#imageLiteral(resourceName: "ic_gear_red"))
            deviceConnect = false
        }
    }

    func updateStatusLabel(errorText: String?) {
        if let error = errorText {
            print("DeviceDetailViewController:", error)
        } else {
            print("DeviceDetailViewController: command sent on device success")
        }
    }
}

extension DeviceInterfaceController {
    
    @objc func checkDevice() {
        if device == nil {
            presentController(withName: "Search", context: contextForSegue(withIdentifier: "Search"))
        } else {
            startPing()
        }
    }

    @objc func ping() {
        if let device = self.device {
            switch device.peripheral.state {
            case .disconnected:
                print("disconnected")
                nameLabel.setText("Disconnected")
                if lastTimeWasConnected {
                    pingTimer?.invalidate()
                    disconnectDevice()
                    updateConnectStatus(success: false, error: LocalizedText(.errorConnect).text)
                }
            case .connecting: print("connecting")
                nameLabel.setText("Connecting")
            case .connected: print("connected")
                nameLabel.setText("Connected")
                break
            case .disconnecting: print("disconnecting")
                nameLabel.setText("Disconnecting")
            @unknown default:
                print("unknown")
            }
        }
    }

    func startPing() {
        if device?.peripheral.state == .connected {
            pingTimer?.invalidate()
            pingTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ping), userInfo: nil, repeats: true)
        }
    }
    
    @objc func disconnectDevice() {
        if let device = device {
            device.disconnect()
            self.device = nil
            return
        }

        print("DeviceDetailViewController: disconnectDevice: device is mising")
    }

    @objc func connectDevice() {
        if let device = device {
            device.connect()
            return
        }

        print("DeviceDetailViewController: connectDevice: device is mising")

        checkDevice()
    }
}

extension DeviceInterfaceController: DeviceInterfaceDelegate {
    
    func disconnect() {
        disconnectDevice()
        UserDefaults.deviceID = nil
        iconImage.setBackgroundImage(#imageLiteral(resourceName: "ic_gear_red"))
    }
    
    func setup(device: BTDevice?) {
        self.device = device
        self.device?.delegate = self
    }
}
