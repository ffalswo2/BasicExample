//
//  UIButton+.swift
//  Animation-1
//
//  Created by 김민재 on 2023/04/21.
//

import UIKit

extension UIButton {
    func shakeButton() {
        self.transform = CGAffineTransform(
            translationX: 0,
            y: -20
        )
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.1,
            initialSpringVelocity: 1,
            options: [.curveEaseInOut]) {
            <#code#>
        }


    }
}
