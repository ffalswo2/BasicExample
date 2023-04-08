//
//  DelegateViewController.swift
//  PreSeminar-2
//
//  Created by 김민재 on 2023/04/07.
//

import UIKit

final class DelegateViewController: UIViewController {

    private let numberLabel: UILabel = {
        let label = UILabel()
        label.text = "조금만 더 눌러봐...0"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.backgroundColor = .black
        label.clipsToBounds = true
        label.layer.cornerRadius = 10

        return label
    }()

    private lazy var button: AnimationButton = {
        let button = AnimationButton()
        var config = UIButton.Configuration.plain()
        config.title = "다음으로"
        config.background.backgroundColor = .systemPurple
        config.baseForegroundColor = .white
        button.configuration = config

        let action = UIAction { _ in
            let pressCountViewController = PressCountViewController()
            pressCountViewController.delegate = self
            self.present(pressCountViewController, animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        setLayout()
    }

    private func style() {
        view.backgroundColor = .white
    }

    private func setLayout() {
        view.addSubview(numberLabel)
        view.addSubview(button)

        numberLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(200)
        }

        button.snp.makeConstraints { make in
            make.top.equalTo(numberLabel.snp.bottom).offset(10)
            make.centerX.equalTo(numberLabel)
        }
    }

    private func updateNumberLabel(_ count: Int) {
        numberLabel.text = count >= 10
        ? "10번 이상 눌렀네...\(count)"
        : "조금만 더 눌러봐...\(count)"
    }
}

// MARK: - Delegate

extension DelegateViewController: PressCountViewControllerDelegate {
    
    func didTapBackButton(count: Int) {
        updateNumberLabel(count)
    }
}
