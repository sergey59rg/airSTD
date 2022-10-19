import UIKit

extension UILabel {
    convenience init(text: String = "", font: UIFont?, color: UIColor?, numberOfLines: Int = 0) {
        self.init()

        self.text = text
        self.font = font
        self.textColor = color
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.2
        self.numberOfLines = numberOfLines
    }
}
