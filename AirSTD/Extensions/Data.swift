import Foundation

extension Data {
    func parseBool() -> Bool? {
        guard count == 1 else { return nil }

        return self[0] != 0 ? true : false
    }

    func parseInt() -> UInt8? {
        guard count == 1 else { return nil }
        return self[0]
    }
}
