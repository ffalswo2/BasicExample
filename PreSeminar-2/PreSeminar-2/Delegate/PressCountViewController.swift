//
//  PressCountViewController.swift
//  PreSeminar-2
//
//  Created by 김민재 on 2023/04/07.
//

import UIKit

protocol PressCountViewControllerDelegate: AnyObject {
    func didTapBackButton(count: Int)
}

final class PressCountViewController: UIViewController {

    private var count = 0

    weak var delegate: PressCountViewControllerDelegate?

    private lazy var pressButton: AnimationButton = {
        let button = AnimationButton()
        var config = UIButton.Configuration.plain()
        config.title = "눌러줘"
        config.background.backgroundColor = .systemPurple
        config.baseForegroundColor = .white
        button.configuration = config

        let action = UIAction { _ in
            self.count += 1
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()

    private lazy var backButton: AnimationButton = {
        let button = AnimationButton()
        var config = UIButton.Configuration.plain()
        config.title = "이전으로"
        config.background.backgroundColor = .systemPurple
        config.baseForegroundColor = .white
        button.configuration = config

        let action = UIAction { _ in
            self.delegate?.didTapBackButton(count: self.count)
            self.dismiss(animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            pressButton,
            backButton
        ])

        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayout()
    }

    private func setLayout() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
