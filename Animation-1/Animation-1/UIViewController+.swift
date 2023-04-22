//
//  UIView+.swift
//  Animation-1
//
//  Created by 김민재 on 2023/04/21.
//

import UIKit

extension UIViewController {
    func showToast(title: String, backGround: UIColor) {
        lazy var toastView = UIView()
        toastView.backgroundColor = backGround
        lazy var titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.text = title

        self.view.addSubview(toastView)
        toastView.addSubview(titleLabel)
        toastView.layer.cornerRadius = 10
        toastView.clipsToBounds = true
        
        toastView.frame = CGRect(
            origin: .init(x: (UIScreen.main.bounds.width - 200) / 2, y: 100),
            size: .init(width: 200, height: 100)
        )

        titleLabel.frame = .init(
            origin: .init(x: 40, y: 20),
            size: .init(width: 120, height: 60)
        )

        UIView.animate(withDuration: 0.5) {
            toastView.alpha = 0
        } completion: { _ in
            toastView.removeFromSuperview()
        }
    }
}
