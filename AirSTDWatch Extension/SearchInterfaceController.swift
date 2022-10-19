//
//  InterfaceController.swift
//  AirSTDWatch Extension
//
//  Created by Sergey Zykov on 18.09.22.
//  Copyright © 2022 Sergey Zykov. All rights reserved.
//

import WatchKit
import Foundation
import CoreBluetooth
import SwiftUI

@available(watchOSApplicationExtension 6.0, *)
class SearchInterfaceController: WKInterfaceController {
    
    @IBOutlet var titleLabel : WKInterfaceLabel!
    @IBOutlet var devicesTable : WKInterfaceTable!
    @IBOutlet var statusLabel: WKInterfaceLabel!
    @IBOutlet var imageLoading: WKInterfaceImage!
    private var manager = BTManager()
    private var devices: [BTDevice] = [] {
        didSet {
            if devices.count > 0 {
                setDevices()
            }
        }
    }
    private var currentDevice: BTDevice?
    weak var delegate: DeviceInterfaceDelegate?
    @State var isLoading : Bool = false
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
        manager.delegate = self
        titleLabel.setText(LocalizedText(.search).text)
        statusLabel.setText(LocalizedText(.powerCar).text)
        let context = context as! DeviceInterfaceContext
        delegate = context.delegate
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        imageLoading.startAnimating()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    private func setDevices() {
        if let deviceID = UserDefaults.deviceID {
            for device in devices where device.detail == deviceID {
                connectDevice(device: device)
            }
        } else {
            imageLoading.stopAnimating()
            imageLoading.setHidden(true)
            titleLabel.setText(LocalizedText(.foundDevice).text)
            statusLabel.setText(LocalizedText(.chooseDevice).text)
            setTable(foundDevices: devices)
        }
    }
    
    func setCurrentDevice(device: BTDevice) {
        self.currentDevice = device
    }
    
    func setTable(foundDevices: [BTDevice]) {
        devicesTable.setNumberOfRows(foundDevices.count, withRowType: "DeviceRowType")
        for item in 0..<foundDevices.count {
            if item > 3 {
                break
            }
            let controller = devicesTable.rowController(at: item) as! DeviceRowController
            controller.nameLabel.setText(foundDevices[item].name)
            controller.detailLabel.setText(foundDevices[item].detail)
        }
    }
    
    private func connectDevice(device: BTDevice) {
        manager.scanning = false
        currentDevice = device
        openDeviceDetail()
    }

    private func openDeviceDetail() {
        currentDevice?.connect()
        delegate?.setup(device: currentDevice)
        dismiss()
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        connectDevice(device: devices[rowIndex])
    }

}

// MARK: BTManagerDelegate
@available(watchOSApplicationExtension 6.0, *)
extension SearchInterfaceController: BTManagerDelegate {
    func didChangeState(state: CBManagerState) {
        devices = manager.devices
    }

    func didDiscover(device: BTDevice) {
        devices = manager.devices
    }
}
