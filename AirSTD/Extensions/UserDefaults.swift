import Foundation

extension UserDefaults {

    private static let deviceIDKey = "deviceID"

    static var deviceID: String? {
        get {
            return UserDefaults.standard.string(forKey: deviceIDKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: deviceIDKey)
        }
    }
}
