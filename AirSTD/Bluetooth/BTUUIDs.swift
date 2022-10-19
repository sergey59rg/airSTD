import CoreBluetooth

struct BTUUIDs {
    static let services: [CBUUID] = [
        CBUUID(string: "c755b47b-d436-4c25-a7cf-828680863dd3"),
        CBUUID(string: "a910")
    ]
    static let cteristics: [CBUUID] = [
        CBUUID(string: "ad9ee860-7105-42e0-8e8c-afb358f74112"),
        CBUUID(string: "a911")
    ]

//    static let controlService = CBUUID(string: "a910")
//    static let controleCharacteristic = CBUUID(string: "a911")
//    static let controlService = CBUUID(string: "c755b47b-d436-4c25-a7cf-828680863dd3")
//    static let controleCharacteristic = CBUUID(string: "ad9ee860-7105-42e0-8e8c-afb358f74112")
}
