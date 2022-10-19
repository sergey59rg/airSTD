import UIKit
import CoreBluetooth

class ScanerSettingsViewController: UIViewController {

    // MARK: Bluetooth
    private var manager = BTManager()
    private var devices: [BTDevice] = [] {
        didSet {
            if isViewLoaded {
                if devices.count > 0 {
                    setDevices()
                }
            }
        }
    }

    // MARK: UI properties
    let titleLabel = UILabel(
        font: UIFont(name: "Roboto-Bold", size: 22),
        color: UIColor.textLightColor
    )

    let statusLabel = UILabel(
        text: LocalizedText(.powerCar).text,
        font: UIFont(name: "Roboto-Regular", size: 14),
        color: UIColor.textLightColor
    )

    let closeButton = UIButton(
        image: #imageLiteral(resourceName: "ic_close"),
        backgroundColor: UIColor.backgroundColor ?? UIColor.black,
        tintColor: UIColor.grayColor,
        target: self,
        action: #selector(closeTap)
    )

    let startScaner = UIButton(
        title: LocalizedText(.startScaner).text,
        titleColor: UIColor.mainRed,
        backgroundColor: UIColor.backgroundColor ?? UIColor.black,
        target: self,
        action: #selector(startScanerTap))

    let activityIndicator = ActivityIndicator()

    var safeArea: UILayoutGuide!

    let viewScaner = UIView()
    let viewSettings = UIView()
    let devicesStackView = UIStackView()

    private var scaner: Bool = true {
        didSet {
            if scaner {
                titleLabel.text = LocalizedText(.search).text
                viewSettings.removeFromSuperview()
                setupConstraintsForScaner()
            } else {
                titleLabel.text = LocalizedText(.settings).text
                viewScaner.removeFromSuperview()
                setupConstraintsForSettings()
            }
        }
    }

    private var currentDevice: BTDevice?

    weak var delegate: DeviceDetailDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        safeArea = view.layoutMarginsGuide

        view.backgroundColor = UIColor.backgroundColor
        
        manager.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if scaner {
            activityIndicator.start()
        }
    }

    func setup(scaner: Bool) {
        self.scaner = scaner
    }

    private func setDevices() {
        if let deviceID = UserDefaults.deviceID {
            for device in devices where device.detail == deviceID {
                connectDevice(device: device)
            }
        } else {
            activityIndicator.removeFromSuperview()
            titleLabel.text = LocalizedText(.foundDevice).text
            statusLabel.text = LocalizedText(.chooseDevice).text

            setStackView(foundDevices: devices)
        }
    }

    func setCurrentDevice(device: BTDevice) {
        self.currentDevice = device
    }

    func setStackView(foundDevices: [BTDevice]) {
        for item in 0..<foundDevices.count {
            if item > 3 {
                break
            }
            let button = UIButton(
                titleName: foundDevices[item].name,
                titleDetail: foundDevices[item].detail,
                backgroundColor: UIColor.backgroundColor ?? UIColor.black,
                tag: item,
                target: self,
                action: #selector(deviceTap(_:))
            )
            devicesStackView.addArrangedSubview(button)
        }
        devicesStackView.axis = .vertical
        devicesStackView.distribution = .fillEqually
        devicesStackView.spacing = 1
    }

    private func connectDevice(device: BTDevice) {
        manager.scanning = false
        currentDevice = device
        openDeviceDetail()
    }

    private func openDeviceDetail() {
        currentDevice?.connect()
        delegate?.setup(device: currentDevice)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: Actions
extension ScanerSettingsViewController {
    @objc private func closeTap() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func startScanerTap() {
        currentDevice?.disconnect()

        UserDefaults.deviceID = nil

        devicesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        scaner = true
        manager.scanning = true
        viewSettings.removeFromSuperview()
        setupConstraintsForScaner()
    }

    @objc private func deviceTap(_ sender: UIButton) {
        if scaner {
            connectDevice(device: devices[sender.tag])
        } else {
            openDeviceDetail()
        }
    }
}

// MARK: BTManagerDelegate
extension ScanerSettingsViewController: BTManagerDelegate {
    func didChangeState(state: CBManagerState) {
        devices = manager.devices
    }

    func didDiscover(device: BTDevice) {
        devices = manager.devices
    }
}
