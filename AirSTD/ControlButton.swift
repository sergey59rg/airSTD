import UIKit

class ControlButton: UIButton {

    private var corners = UIRectCorner()

    convenience init(
        image: UIImage,
        tag: Int,
        target: Any,
        actionOn: Selector,
        actionOff: Selector) {
        self.init(type: .system)

        self.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        self.tintColor = UIColor.mainGray
        self.backgroundColor = UIColor.formColor
        self.clipsToBounds = true
        self.tag = tag

        self.addTarget(target, action: actionOn, for: .touchDown)
        self.addTarget(target, action: actionOff, for: .touchUpInside)
        self.addTarget(target, action: actionOff, for: .touchUpOutside)
        self.addTarget(target, action: actionOff, for: .touchCancel)
    }

    func setup(corners: UIRectCorner) {
        self.corners = corners
    }

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.backgroundColor = UIColor.formPressedColor
            } else {
                self.backgroundColor = UIColor.formColor
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.roundCorners(corners: corners, radius: 30)
    }
}
