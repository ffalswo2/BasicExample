//
//  CommonView.swift
//  SOPT32-Seminar-3
//
//  Created by 김민재 on 2023/04/22.
//

import UIKit
import Then
import SnapKit

final class CommonView: BaseView {

    let nameLabel = UILabel().then {
        $0.text = "이름이 무엇인가요!?"
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .blue
        $0.textAlignment = .center
    }

    override func setLayout() {
        self.addSubview(nameLabel)

        nameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

}
