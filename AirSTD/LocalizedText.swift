import Foundation

struct LocalizedText {

    private let localeKey: LocaleKey

    init(_ localeKey: LocaleKey) {
        self.localeKey = localeKey
    }

    var text: String {
        return NSLocalizedString(localeKey.rawValue, comment: "")
    }
}

enum LocaleKey: String, CaseIterable {

    case all
    case left
    case front
    case right
    case rear
    case search
    case powerCar
    case settings
    case startScaner
    case foundDevice
    case chooseDevice
    case error
    case close
    case errorConnect
}
