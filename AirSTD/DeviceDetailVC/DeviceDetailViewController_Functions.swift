import UIKit

protocol DeviceDetailDelegate: class {
    func setup(device: BTDevice?)
}

extension DeviceDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        safeArea = view.layoutMarginsGuide

        view.backgroundColor = UIColor.backgroundColor

        setupConstraints()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.checkDevice),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        allView.mask(rect: CGRect(x: 97, y: 7, width: 46, height: 46), invert: true)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkDevice()
    }

    @objc func checkDevice() {
        if device == nil {
            let scanerVC = ScanerSettingsViewController()
            scanerVC.delegate = self
            scanerVC.setup(scaner: true)
            scanerVC.modalPresentationStyle = .custom
            scanerVC.modalTransitionStyle = .crossDissolve
            self.present(scanerVC, animated: true, completion: nil)
        } else {
            startPing()
        }
    }

    @objc func ping() {
        if let device = self.device {
            switch device.peripheral.state {
            case .disconnected:
                print("disconnected")
                if lastTimeWasConnected {
                    pingTimer?.invalidate()
                    disconnectDevice()
                    updateConnectStatus(success: false, error: LocalizedText(.errorConnect).text)
                }
            case .connecting: print("connecting")
            case .connected:
                //print("connected")
                break
            case .disconnecting: print("disconnecting")
            @unknown default:
                print("unknown")
            }
        }
    }

    func startPing() {
        if device?.peripheral.state == .connected {
            pingTimer?.invalidate()
            pingTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ping), userInfo: nil, repeats: true)
        }
    }
}

// MARK: BTDeviceDelegate
extension DeviceDetailViewController: BTDeviceDelegate {
    func updateConnectStatus(success: Bool, error: String? = nil) {
        lastTimeWasConnected = success
        if success {
            UserDefaults.deviceID = device?.detail
            gearImageView.setImage(#imageLiteral(resourceName: "ic_gear_green"), for: .normal)
            deviceConnect = true
            startPing()
        } else {
            let alert = UIAlertController(title: LocalizedText(.error).text, message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: LocalizedText(.close).text, style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            gearImageView.setImage(#imageLiteral(resourceName: "ic_gear_red"), for: .normal)
            deviceConnect = false
        }
    }

    func updateStatusLabel(errorText: String?) {
        if let error = errorText {
            print("DeviceDetailViewController:", error)
        } else {
            print("DeviceDetailViewController: command sent on device success")
        }
    }
}

extension DeviceDetailViewController: DeviceDetailDelegate {
    func setup(device: BTDevice?) {
        self.device = device
        self.device?.delegate = self
    }
}
