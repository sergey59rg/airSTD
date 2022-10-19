//
//  DeviceInterfaceContext.swift
//  AirSTDWatch Extension
//
//  Created by Сергей on 23.09.2022.
//  Copyright © 2022 Sergey Zykov. All rights reserved.
//

import WatchKit

protocol Context {
    associatedtype DelType
    associatedtype ObjType
    var delegate: DelType? { get set }
    var object: ObjType? { get set }
}

class DeviceInterfaceContext: Context {
    typealias DelType = DeviceInterfaceDelegate
    typealias ObjType = BTDevice
    var delegate: DelType?
    weak var object: ObjType?
}
