import UIKit

extension DeviceDetailViewController {
    func setupConstraints() {

        if UIScreen.main.bounds.height < 600 {
            factor = UIScreen.main.bounds.height/2900
        } else if UIScreen.main.bounds.height < 800 {
            factor = UIScreen.main.bounds.height/1100
        }

        view.addSubview(gearImageView)
        view.addSubview(logoImageView)

        gearImageView.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(43 * factor)
            make.trailing.equalTo(view.snp.trailing).offset(-31)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }

        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(85 * factor)
            make.centerX.equalTo(view.snp.centerX)
            make.size.equalTo(CGSize(width: 188, height: 74))
        }

        setupConstraintsAll()
        setupConstraintsFrontLeft()
        setupConstraintsFront()
        setupConstraintsFrontRight()
        setupConstraintsRearLeft()
        setupConstraintsRear()
        setupConstraintsRearRight()
    }

    // MARK: All
    private func setupConstraintsAll() {
        let allCircleView = UIView()
        allCircleView.frame = CGRect(x: 100, y: 7, width: 44, height: 44)
        allCircleView.layer.cornerRadius = 22
        allCircleView.clipsToBounds = true
        allCircleView.backgroundColor = UIColor.formColor

        allPlusButton.setup(corners: [.topLeft, .bottomLeft])
        allMinusButton.setup(corners: [.topRight, .bottomRight])

        view.addSubview(allView)
        allView.addSubview(allPlusButton)
        allView.addSubview(allMinusButton)
        view.addSubview(allCircleView)
        allCircleView.addSubview(allLabel)

        allView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(61 * factor)
            make.centerX.equalTo(view.snp.centerX)
            make.size.equalTo(CGSize(width: 240, height: 60))
        }

        allPlusButton.snp.makeConstraints { make in
            make.top.equalTo(allView.snp.top)
            make.leading.equalTo(allView.snp.leading)
            make.size.equalTo(CGSize(width: 119, height: 60))
        }

        allMinusButton.snp.makeConstraints { make in
            make.top.equalTo(allView.snp.top)
            make.leading.equalTo(allPlusButton.snp.trailing).offset(2)
            make.size.equalTo(CGSize(width: 119, height: 60))
        }

        allCircleView.snp.makeConstraints { make in
            make.center.equalTo(allView.snp.center)
            make.size.equalTo(CGSize(width: 43, height: 43))
        }

        allLabel.snp.makeConstraints { make in
            make.center.equalTo(allCircleView.snp.center)
        }
    }

    // MARK: Front Left
    private func setupConstraintsFrontLeft() {

        frontLeftPlusButton.setup(corners: [.topLeft, .topRight])
        frontLeftMinusButton.setup(corners: [.bottomLeft, .bottomRight])

        view.addSubview(frontLeftView)
        frontLeftView.addSubview(frontLeftPlusButton)
        frontLeftView.addSubview(frontLeftMinusButton)
        frontLeftView.addSubview(frontLeftLabel)

        frontLeftView.snp.makeConstraints { make in
            make.top.equalTo(allView.snp.bottom).offset(53 * factor)
            make.leading.equalTo(allView.snp.leading)
            make.size.equalTo(CGSize(width: 50, height: 160))
        }

        frontLeftPlusButton.snp.makeConstraints { make in
            make.top.equalTo(frontLeftView.snp.top)
            make.leading.equalTo(frontLeftView.snp.leading)
            make.size.equalTo(CGSize(width: 50, height: 80))
        }

        frontLeftMinusButton.snp.makeConstraints { make in
            make.top.equalTo(frontLeftPlusButton.snp.bottom)
            make.leading.equalTo(frontLeftView.snp.leading)
            make.size.equalTo(CGSize(width: 50, height: 80))
        }

        frontLeftLabel.snp.makeConstraints { make in
            make.center.equalTo(frontLeftView.snp.center)
        }
    }

    // MARK: Front
    private func setupConstraintsFront() {
        frontPlusButton.setup(corners: [.topLeft, .topRight])
        frontMinusButton.setup(corners: [.bottomLeft, .bottomRight])

        view.addSubview(frontView)
        frontView.addSubview(frontPlusButton)
        frontView.addSubview(frontMinusButton)
        frontView.addSubview(frontLabel)

        frontView.snp.makeConstraints { make in
            make.top.equalTo(allView.snp.bottom).offset(43 * factor)
            make.centerX.equalTo(view.snp.centerX)
            make.size.equalTo(CGSize(width: 60, height: 180))
        }

        frontPlusButton.snp.makeConstraints { make in
            make.top.equalTo(frontView.snp.top)
            make.leading.equalTo(frontView.snp.leading)
            make.size.equalTo(CGSize(width: 60, height: 90))
        }

        frontMinusButton.snp.makeConstraints { make in
            make.top.equalTo(frontPlusButton.snp.bottom)
            make.leading.equalTo(frontView.snp.leading)
            make.size.equalTo(CGSize(width: 60, height: 90))
        }

        frontLabel.snp.makeConstraints { make in
            make.center.equalTo(frontView.snp.center)
        }
    }

    // MARK: Front Right
    private func setupConstraintsFrontRight() {
        frontRightPlusButton.setup(corners: [.topLeft, .topRight])
        frontRightMinusButton.setup(corners: [.bottomLeft, .bottomRight])

        view.addSubview(frontRightView)
        frontRightView.addSubview(frontRightPlusButton)
        frontRightView.addSubview(frontRightMinusButton)
        frontRightView.addSubview(frontRightLabel)

        frontRightView.snp.makeConstraints { make in
            make.top.equalTo(allView.snp.bottom).offset(53 * factor)
            make.trailing.equalTo(allView.snp.trailing)
            make.size.equalTo(CGSize(width: 50, height: 160))
        }

        frontRightPlusButton.snp.makeConstraints { make in
            make.top.equalTo(frontRightView.snp.top)
            make.leading.equalTo(frontRightView.snp.leading)
            make.size.equalTo(CGSize(width: 50, height: 80))
        }

        frontRightMinusButton.snp.makeConstraints { make in
            make.top.equalTo(frontRightPlusButton.snp.bottom)
            make.leading.equalTo(frontRightView.snp.leading)
            make.size.equalTo(CGSize(width: 50, height: 80))
        }

        frontRightLabel.snp.makeConstraints { make in
            make.center.equalTo(frontRightView.snp.center)
        }
    }

    // MARK: RearLeft
    private func setupConstraintsRearLeft() {
        let rearLeftView = UIView()

        rearLeftPlusButton.setup(corners: [.topLeft, .topRight])
        rearLeftMinusButton.setup(corners: [.bottomLeft, .bottomRight])

        view.addSubview(rearLeftView)
        rearLeftView.addSubview(rearLeftPlusButton)
        rearLeftView.addSubview(rearLeftMinusButton)
        rearLeftView.addSubview(rearLeftLabel)

        rearLeftView.snp.makeConstraints { make in
            make.top.equalTo(frontLeftView.snp.bottom).offset(65 * factor)
            make.leading.equalTo(allView.snp.leading)
            make.size.equalTo(CGSize(width: 50, height: 160))
        }

        rearLeftPlusButton.snp.makeConstraints { make in
            make.top.equalTo(rearLeftView.snp.top)
            make.leading.equalTo(rearLeftView.snp.leading)
            make.size.equalTo(CGSize(width: 50, height: 80))
        }

        rearLeftMinusButton.snp.makeConstraints { make in
            make.top.equalTo(rearLeftPlusButton.snp.bottom)
            make.leading.equalTo(rearLeftView.snp.leading)
            make.size.equalTo(CGSize(width: 50, height: 80))
        }

        rearLeftLabel.snp.makeConstraints { make in
            make.center.equalTo(rearLeftView.snp.center)
        }
    }

    // MARK: Rar
    private func setupConstraintsRear() {
        let rearView = UIView()

        rearPlusButton.setup(corners: [.topLeft, .topRight])
        rearMinusButton.setup(corners: [.bottomLeft, .bottomRight])

        view.addSubview(rearView)
        rearView.addSubview(rearPlusButton)
        rearView.addSubview(rearMinusButton)
        rearView.addSubview(rearLabel)

        rearView.snp.makeConstraints { make in
            make.top.equalTo(frontView.snp.bottom).offset(45 * factor)
            make.centerX.equalTo(view.snp.centerX)
            make.size.equalTo(CGSize(width: 60, height: 180))
        }

        rearPlusButton.snp.makeConstraints { make in
            make.top.equalTo(rearView.snp.top)
            make.leading.equalTo(rearView.snp.leading)
            make.size.equalTo(CGSize(width: 60, height: 90))
        }

        rearMinusButton.snp.makeConstraints { make in
            make.top.equalTo(rearPlusButton.snp.bottom)
            make.leading.equalTo(rearView.snp.leading)
            make.size.equalTo(CGSize(width: 60, height: 90))
        }

        rearLabel.snp.makeConstraints { make in
            make.center.equalTo(rearView.snp.center)
        }
    }

    // MARK: Front Right
    private func setupConstraintsRearRight() {
        let rearRightView = UIView()

        rearRightPlusButton.setup(corners: [.topLeft, .topRight])
        rearRightMinusButton.setup(corners: [.bottomLeft, .bottomRight])

        view.addSubview(rearRightView)
        rearRightView.addSubview(rearRightPlusButton)
        rearRightView.addSubview(rearRightMinusButton)
        rearRightView.addSubview(rearRightLabel)

        rearRightView.snp.makeConstraints { make in
            make.top.equalTo(frontRightView.snp.bottom).offset(65 * factor)
            make.trailing.equalTo(allView.snp.trailing)
            make.size.equalTo(CGSize(width: 50, height: 160))
        }

        rearRightPlusButton.snp.makeConstraints { make in
            make.top.equalTo(rearRightView.snp.top)
            make.leading.equalTo(rearRightView.snp.leading)
            make.size.equalTo(CGSize(width: 50, height: 80))
        }

        rearRightMinusButton.snp.makeConstraints { make in
            make.top.equalTo(rearRightPlusButton.snp.bottom)
            make.leading.equalTo(rearRightView.snp.leading)
            make.size.equalTo(CGSize(width: 50, height: 80))
        }

        rearRightLabel.snp.makeConstraints { make in
            make.center.equalTo(rearRightView.snp.center)
        }
    }
}
