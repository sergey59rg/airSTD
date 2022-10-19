import UIKit
import CoreBluetooth

class DeviceDetailViewController: UIViewController {

    let gearImageView = UIButton(
        image: #imageLiteral(resourceName: "ic_gear_red"),
        backgroundColor: UIColor.backgroundColor ?? UIColor.black,
        target: self,
        action: #selector(openSettings)
    )
    
    let logoImageView = UIImageView(image: #imageLiteral(resourceName: "airstd_logo 1"), contentMode: .scaleAspectFill)

    let allPlusButton = ControlButton(
        image: #imageLiteral(resourceName: "ic_plus"),
        tag: 0,
        target: self,
        actionOn: #selector(tapOn(_ :)),
        actionOff: #selector(tapOff(_ :))
    )
    let allMinusButton = ControlButton(
        image: #imageLiteral(resourceName: "ic_minus"),
        tag: 1,
        target: self,
        actionOn: #selector(tapOn(_ :)),
        actionOff: #selector(tapOff(_ :))
    )

    let frontLeftPlusButton = ControlButton(
        image: #imageLiteral(resourceName: "ic_plus"),
        tag: 2,
        target: self,
        actionOn: #selector(tapOn(_ :)),
        actionOff: #selector(tapOff(_ :))
    )
    let frontLeftMinusButton = ControlButton(
        image: #imageLiteral(resourceName: "ic_minus"),
        tag: 3,
        target: self,
        actionOn: #selector(tapOn(_ :)),
        actionOff: #selector(tapOff(_ :))
    )

    let frontPlusButton = ControlButton(
        image: #imageLiteral(resourceName: "ic_plus"),
        tag: 4,
        target: self,
        actionOn: #selector(tapOn(_ :)),
        actionOff: #selector(tapOff(_ :))
    )
    let frontMinusButton = ControlButton(
        image: #imageLiteral(resourceName: "ic_minus"),
        tag: 5,
        target: self,
        actionOn: #selector(tapOn(_ :)),
        actionOff: #selector(tapOff(_ :))
    )

    let frontRightPlusButton = ControlButton(
        image: #imageLiteral(resourceName: "ic_plus"),
        tag: 6,
        target: self,
        actionOn: #selector(tapOn(_ :)),
        actionOff: #selector(tapOff(_ :))
    )
    let frontRightMinusButton = ControlButton(
        image: #imageLiteral(resourceName: "ic_minus"),
        tag: 7,
        target: self,
        actionOn: #selector(tapOn(_ :)),
        actionOff: #selector(tapOff(_ :))
    )

    let rearLeftPlusButton = ControlButton(
        image: #imageLiteral(resourceName: "ic_plus"),
        tag: 8,
        target: self,
        actionOn: #selector(tapOn(_ :)),
        actionOff: #selector(tapOff(_ :))
    )
    let rearLeftMinusButton = ControlButton(
        image: #imageLiteral(resourceName: "ic_minus"),
        tag: 9,
        target: self,
        actionOn: #selector(tapOn(_ :)),
        actionOff: #selector(tapOff(_ :))
    )

    let rearPlusButton = ControlButton(
        image: #imageLiteral(resourceName: "ic_plus"),
        tag: 10,
        target: self,
        actionOn: #selector(tapOn(_ :)),
        actionOff: #selector(tapOff(_ :))
    )
    let rearMinusButton = ControlButton(
        image: #imageLiteral(resourceName: "ic_minus"),
        tag: 11,
        target: self,
        actionOn: #selector(tapOn(_ :)),
        actionOff: #selector(tapOff(_ :))
    )

    let rearRightPlusButton = ControlButton(
        image: #imageLiteral(resourceName: "ic_plus"),
        tag: 12,
        target: self,
        actionOn: #selector(tapOn(_ :)),
        actionOff: #selector(tapOff(_ :))
    )
    let rearRightMinusButton = ControlButton(
        image: #imageLiteral(resourceName: "ic_minus"),
        tag: 13,
        target: self,
        actionOn: #selector(tapOn(_ :)),
        actionOff: #selector(tapOff(_ :))
    )

    let statusLabel = UILabel(font: UIFont.systemFont(ofSize: 12, weight: .regular), color: UIColor.gray)

    let allLabel = UILabel(
        text: LocalizedText(.all).text,
        font: UIFont(name: "Roboto-Bold", size: 12),
        color: UIColor.textLightColor
    )
    let frontLeftLabel = UILabel(
        text: LocalizedText(.left).text,
        font: UIFont(name: "Roboto-Medium", size: 12),
        color: UIColor.textLightColor
    )
    let frontLabel = UILabel(
        text: LocalizedText(.front).text,
        font: UIFont(name: "Roboto-Bold", size: 14),
        color: UIColor.textLightColor
    )
    let frontRightLabel = UILabel(
        text: LocalizedText(.right).text,
        font: UIFont(name: "Roboto-Medium", size: 12),
        color: UIColor.textLightColor
    )
    let rearLeftLabel = UILabel(
        text: LocalizedText(.left).text,
        font: UIFont(name: "Roboto-Medium", size: 12),
        color: UIColor.textLightColor
    )
    let rearLabel = UILabel(
        text: LocalizedText(.rear).text,
        font: UIFont(name: "Roboto-Bold", size: 14),
        color: UIColor.textLightColor
    )
    let rearRightLabel = UILabel(
        text: LocalizedText(.right).text,
        font: UIFont(name: "Roboto-Medium", size: 12),
        color: UIColor.textLightColor
    )

    let allView = UIView()
    let frontLeftView = UIView()
    let frontView = UIView()
    let frontRightView = UIView()

    var safeArea: UILayoutGuide!

    var factor: CGFloat = 1

    var deviceConnect = false

    var device: BTDevice? {
        didSet {
            navigationItem.title = device?.name ?? "Device"
        }
    }

    deinit {
        disconnectDevice()
    }

    var lastTimeWasConnected = false
    var pingTimer: Timer?
}
