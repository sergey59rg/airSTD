import UIKit

extension UIButton {
    convenience init(
        image: UIImage,
        backgroundColor: UIColor,
        tintColor: UIColor?,
        target: Any,
        action: Selector
    ) {
        self.init(type: .system)

        self.setImage(image, for: .normal)
        self.tintColor = tintColor

        self.backgroundColor = backgroundColor

        self.addTarget(target, action: action, for: .touchUpInside)
    }

    convenience init(
        image: UIImage,
        backgroundColor: UIColor,
        target: Any,
        action: Selector
    ) {
        self.init(type: .custom)

        self.setImage(image, for: .normal)

        self.backgroundColor = backgroundColor

        self.addTarget(target, action: action, for: .touchUpInside)
    }

    convenience init(
        title: String,
        titleColor: UIColor?,
        backgroundColor: UIColor,
        target: Any,
        action: Selector
    ) {
        self.init(type: .system)

        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)

        self.backgroundColor = backgroundColor

        self.addTarget(target, action: action, for: .touchUpInside)
    }

    convenience init(
        titleName: String,
        titleDetail: String,
        backgroundColor: UIColor,
        tag: Int,
        target: Any,
        action: Selector
    ) {
        self.init(type: .system)

        let nameLabel = UILabel(
            text: titleName,
            font: UIFont(name: "Roboto-Medium", size: 17),
            color: UIColor.deviceNameColor
        )
        let detailLabel = UILabel(
            text: titleDetail,
            font: UIFont(name: "Roboto-Regular", size: 12),
            color: UIColor.textLightColor
        )

        self.backgroundColor = backgroundColor
        self.tag = tag

        self.addTarget(target, action: action, for: .touchUpInside)

        addSubview(nameLabel)
        addSubview(detailLabel)

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading)
        }

        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(7)
            make.leading.equalTo(self.snp.leading)
        }
    }
}
