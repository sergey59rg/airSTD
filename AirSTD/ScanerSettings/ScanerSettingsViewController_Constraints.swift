import UIKit
import SnapKit

extension ScanerSettingsViewController {
    func setupConstraintsForScaner() {
        view.addSubview(viewScaner)
        viewScaner.addSubview(titleLabel)
        viewScaner.addSubview(activityIndicator)
        viewScaner.addSubview(devicesStackView)
        viewScaner.addSubview(statusLabel)

        viewScaner.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(viewScaner.snp.top).offset(129)
            make.centerX.equalTo(viewScaner.snp.centerX)
            make.height.equalTo(26)
        }

        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(viewScaner.snp.center)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }

        devicesStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(48)
            make.leading.equalTo(viewScaner.snp.leading).offset(40)
            make.trailing.equalTo(viewScaner.snp.trailing).offset(-40)
            make.bottom.equalTo(statusLabel.snp.top).offset(-10)
        }

        statusLabel.snp.makeConstraints { make in
            make.bottom.equalTo(viewScaner.snp.bottom).offset(-113)
            make.centerX.equalTo(viewScaner.snp.centerX)
            make.height.equalTo(16)
        }

        activityIndicator.start()
    }

    func setupConstraintsForSettings() {
        view.addSubview(viewSettings)
        viewSettings.addSubview(titleLabel)
        viewSettings.addSubview(closeButton)
        viewSettings.addSubview(devicesStackView)
        viewSettings.addSubview(startScaner)

        viewSettings.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(viewSettings.snp.top).offset(129)
            make.centerX.equalTo(viewSettings.snp.centerX)
            make.height.equalTo(26)
        }

        closeButton.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(44)
            make.trailing.equalTo(viewSettings.snp.trailing).offset(-30)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }

        devicesStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(48)
            make.leading.equalTo(viewSettings.snp.leading).offset(40)
            make.trailing.equalTo(viewSettings.snp.trailing).offset(-40)
            make.bottom.equalTo(startScaner.snp.top).offset(-10)
        }

        startScaner.snp.makeConstraints { make in
            make.bottom.equalTo(viewSettings.snp.bottom).offset(-90)
            make.centerX.equalTo(viewSettings.snp.centerX)
            make.height.equalTo(44)
        }
    }
}
