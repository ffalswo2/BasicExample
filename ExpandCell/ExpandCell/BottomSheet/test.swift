//
//  ㅅㄷㄴㅅ.swift
//  ExpandCell
//
//  Created by 김민재 on 2023/07/04.
//

import UIKit

class BottomTest: UIView {
    private var viewTranslation: CGPoint = .init(x: 0, y: 0)
    private var viewVelocity: CGPoint = .init(x: 0, y: 0)

    init() {
        super.init(frame: .zero)
        self.setLayout()
        self.addGestureInView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addGestureInView() {
        let gesture = UIPanGestureRecognizer(target: self,
                                             action: #selector(didMove(_:)))
        self.addGestureRecognizer(gesture)
    }

    @objc private func didMove(_ sender: UIPanGestureRecognizer) {
        viewTranslation = sender.translation(in: self)
        viewVelocity = sender.translation(in: self)
        print(self.viewVelocity)
        switch sender.state {
        case .changed:
            if viewTranslation.y > 0 {
                self.transform = CGAffineTransform(translationX: 0, y: viewTranslation.y)
            }
        case .ended:
            if viewTranslation.y < self.frame.height / 2 {
                UIView.animate(withDuration: 0.3, delay: 0) {
                    self.transform = CGAffineTransform(translationX: 0, y: 0)
                }
            } else {
                UIView.animate(withDuration: 0.3, delay: 0) {
                    self.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
                }
            }
        default:
            break
        }
    }


    private func setLayout() {
        self.addSubview(handleView)

        handleView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(30)
            $0.height.equalTo(10)
        }
        handleView.layer.cornerRadius = 5
        handleView.clipsToBounds = true
    }

    private var handleView = UIView().then {
        $0.backgroundColor = .gray
    }
}
