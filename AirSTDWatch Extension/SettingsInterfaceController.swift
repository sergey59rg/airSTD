//
//  SettingsInterfaceController.swift
//  AirSTDWatch Extension
//
//  Created by Сергей on 25.09.2022.
//  Copyright © 2022 Sergey Zykov. All rights reserved.
//

import WatchKit
import Foundation
import CoreBluetooth

class SettingsInterfaceController: WKInterfaceController {
    
    @IBOutlet var titleLabel : WKInterfaceLabel!
    @IBOutlet var devicesTable : WKInterfaceTable!
    @IBOutlet var startButton: WKInterfaceButton!
    private var device: BTDevice?
    weak var delegate: DeviceInterfaceDelegate?
        
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
        let context = context as! DeviceInterfaceContext
        device = context.object
        delegate = context.delegate
        titleLabel.setText(LocalizedText(.settings).text)
        let attString = NSMutableAttributedString(string: LocalizedText(.startScaner).text)
        attString.setAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], range: NSMakeRange(0, attString.length))
        startButton.setAttributedTitle(attString)
        startButton.setBackgroundColor(.black)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        setDevice()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func startButtonPressed() {
        delegate?.disconnect()
        dismiss()
    }
    
    private func setDevice() {
        setTable(foundDevices: device!)
    }
    
    func setTable(foundDevices: BTDevice) {
        devicesTable.setNumberOfRows(1, withRowType: "DeviceRowType")
        let controller = devicesTable.rowController(at: 0) as! DeviceRowController
        controller.nameLabel.setText(foundDevices.name)
        controller.detailLabel.setText(foundDevices.detail)
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        dismiss()
    }

}
