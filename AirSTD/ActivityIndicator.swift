import UIKit

class ActivityIndicator: UIView {
    var indicator = UIView()
    private let shapeLayer = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: .zero)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func start() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi * 2
        rotationAnimation.duration = 2.0
        rotationAnimation.repeatCount = .infinity
        rotationAnimation.isRemovedOnCompletion = false
        indicator.layer.add(rotationAnimation, forKey: nil)

        let strokeStart = CABasicAnimation(keyPath: "strokeStart")
        strokeStart.fromValue = 0
        strokeStart.toValue = 1
        strokeStart.duration = 2.5
        strokeStart.beginTime = 2.5
        strokeStart.isRemovedOnCompletion = false

        let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        strokeEnd.fromValue = 0
        strokeEnd.toValue = 1
        strokeEnd.duration = 2.5
        strokeEnd.beginTime = 0
        strokeStart.isRemovedOnCompletion = false

        let group = CAAnimationGroup()
        group.animations = [strokeEnd, strokeStart]
        group.duration = 5
        group.repeatCount = .infinity

        shapeLayer.add(group, forKey: nil)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        indicator.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        addSubview(indicator)

        let shapeLayer1 = CAShapeLayer()
        let path1 = UIBezierPath(arcCenter: .init(x: 22, y: 22),
                              radius: 22,
                              startAngle: 0, endAngle: .pi * 2,
                              clockwise: true
        )
        shapeLayer1.path = path1.cgPath
        shapeLayer1.strokeColor = UIColor.formColor?.cgColor ?? UIColor.lightGray.cgColor
        shapeLayer1.fillColor = UIColor.clear.cgColor
        shapeLayer1.lineWidth = 4

        let path2 = UIBezierPath(arcCenter: .init(x: 22, y: 22),
                              radius: 22,
                              startAngle: 0, endAngle: .pi * 2,
            clockwise: true
        )
        shapeLayer.path = path2.cgPath
        shapeLayer.strokeColor = UIColor.formPressedColor?.cgColor ?? UIColor.black.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 1

        indicator.layer.addSublayer(shapeLayer1)
        indicator.layer.addSublayer(shapeLayer)
    }
}
