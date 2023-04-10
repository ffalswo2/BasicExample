//
//  HalfBottomSheetViewController.swift
//  PreSeminar-2
//
//  Created by 김민재 on 2023/04/08.
//

import UIKit
import SnapKit

final class HalfBottomSheetViewController: UIViewController {

    private lazy var button: UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = .blue
        let button = UIButton(configuration: config)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        setLayout()
        setAction()
    }

    private func style() {
        view.backgroundColor = .white
    }

    private func setLayout() {
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

    }

    private func setAction() {
        let action = UIAction { _ in
            let bottomSheetViewController = BottomSheetViewController()
            bottomSheetViewController.modalPresentationStyle = .overFullScreen
            self.present(bottomSheetViewController, animated: false) {
                bottomSheetViewController.showBottomSheetWithAnimation()
            }
        }
        button.addAction(action, for: .touchUpInside)
    }
}
