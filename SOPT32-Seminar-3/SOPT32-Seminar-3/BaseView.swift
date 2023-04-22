//
//  BaseView.swift
//  SOPT32-Seminar-3
//
//  Created by 김민재 on 2023/04/22.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setLayout() {

    }
}
