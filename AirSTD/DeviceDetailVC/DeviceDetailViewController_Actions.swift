import UIKit

// MARK: Actions
extension DeviceDetailViewController {

    @objc func tapOn(_ sender: UIButton) {
        let impactMed = UIImpactFeedbackGenerator(style: .medium)
        impactMed.impactOccurred()

        switch sender.tag {
        case 0:
            print("allPlusTapOn")
            device?.control = [0, 4, 8, 0xc]
        case 1:
            print("allMinusTapOn")
            device?.control = [2, 6, 0xa, 0xe]
        case 2:
            print("frontLeftPlusTapOn")
            device?.control = [0]
        case 3:
            print("frontLeftMinusTapOn")
            device?.control = [2]
        case 4:
            print("frontPlusTapOn")
            device?.control = [0, 4]
        case 5:
            print("frontMinusTapOn")
            device?.control = [2, 6]
        case 6:
            print("frontRightPlusTapOn")
            device?.control = [4]
        case 7:
            print("frontRightMinusTapOn")
            device?.control = [6]
        case 8:
            print("rearLeftPlusTapOn")
            device?.control = [8]
        case 9:
            print("rearLeftMinusTapOn")
            device?.control = [0xa]
        case 10:
            print("rearPlusTapOn")
            device?.control = [8, 0xc]
        case 11:
            print("rearMinusTapOn")
            device?.control = [0xa, 0xe]
        case 12:
            print("rearRightPlusTapOn")
            device?.control = [0xc]
        case 13:
            print("rearRightMinusTapOn")
            device?.control = [0xe]
        default:
            print("Error!")
        }
    }

    @objc func tapOff(_ sender: UIButton) {
        let impactMed = UIImpactFeedbackGenerator(style: .light)
        impactMed.impactOccurred()

        switch sender.tag {
        case 0:
            print("allPlusTapOff")
            device?.control = [1, 5, 9, 0xd]
        case 1:
            print("allMinusTapOff")
            device?.control = [3, 7, 0xb, 0xf]
        case 2:
            print("frontLeftPlusTapOff")
            device?.control = [1]
        case 3:
            print("frontLeftMinusTapOff")
            device?.control = [3]
        case 4:
            print("frontPlusTapOff")
            device?.control = [1, 5]
        case 5:
            print("frontMinusTapOff")
            device?.control = [3, 7]
        case 6:
            print("frontRightPlusTapOff")
            device?.control = [5]
        case 7:
            print("frontRightMinusTapOff")
            device?.control = [7]
        case 8:
            print("rearLeftPlusTapOff")
            device?.control = [9]
        case 9:
            print("rearLeftMinusTapOff")
            device?.control = [0xb]
        case 10:
            print("rearPlusTapOff")
            device?.control = [9, 0xd]
        case 11:
            print("rearMinusTapOff")
            device?.control = [0xb, 0xf]
        case 12:
            print("rearRightPlusTapOff")
            device?.control = [0xd]
        case 13:
            print("rearRightMinusTapOff")
            device?.control = [0xf]
        default:
            print("Error!")
        }
    }

    @objc func openSettings() {
        let settingsVC = ScanerSettingsViewController()
        settingsVC.delegate = self
        settingsVC.modalPresentationStyle = .custom
        if let device = self.device, deviceConnect {
            settingsVC.setCurrentDevice(device: device)
            settingsVC.setStackView(foundDevices: [device])
            settingsVC.setup(scaner: false)
        } else {
            settingsVC.setup(scaner: true)
        }
        self.present(settingsVC, animated: true, completion: nil)
    }

    @objc func disconnectDevice() {
        if let device = device {
            device.disconnect()
            self.device = nil
            return
        }

        print("DeviceDetailViewController: disconnectDevice: device is mising")
    }

    @objc func connectDevice() {
        if let device = device {
            device.connect()
            return
        }

        print("DeviceDetailViewController: connectDevice: device is mising")

        checkDevice()
    }
}
