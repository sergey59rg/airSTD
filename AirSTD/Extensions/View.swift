import UIKit

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
    )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

    func mask(rect: CGRect, invert: Bool = false) {
        let maskLayer = CAShapeLayer()
        let path = CGMutablePath()
        if invert {
            path.addRect(bounds)
        }
        path.addEllipse(in: rect)
        maskLayer.path = path
        if invert {
            maskLayer.fillRule = .evenOdd
        }
        layer.mask = maskLayer
    }
}
