//
//  HousRuleCollectionViewCell.swift
//  DiffableExample
//
//  Created by 김민재 on 2023/05/11.
//

import UIKit

class HousRuleCollectionViewCell: UICollectionViewCell {

    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(rule: HousRule) {
        label.text = rule.name
    }
}
