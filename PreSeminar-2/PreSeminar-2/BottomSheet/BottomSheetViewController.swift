//
//  BottomSheetViewController.swift
//  PreSeminar-2
//
//  Created by 김민재 on 2023/04/09.
//

import UIKit

final class BottomSheetViewController: UIViewController {

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .black.withAlphaComponent(0.5)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first,
           touch.view == self.view {
            hideBottomSheetWithAnimation()
        }
    }

    private func setupUI() {
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(0)
        }

        containerView.layer.cornerRadius = 12
        containerView.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner
        ]
    }
}

// MARK: - Show/Hide Animation

extension BottomSheetViewController {
    func showBottomSheetWithAnimation() {
        self.containerView.snp.updateConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.height / 2)
        }
        UIView.animate(withDuration: 0.8) {
            self.view.layoutIfNeeded()
        }
    }

    func hideBottomSheetWithAnimation() {
        self.containerView.snp.updateConstraints { make in
            make.height.equalTo(0)
        }
        UIView.animate(withDuration: 0.8) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.view.backgroundColor = .white
            self.dismiss(animated: true)
        }
    }
}


