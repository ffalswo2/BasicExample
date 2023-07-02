//
//  MonthCollectionViewCell.swift
//  ExpandCell
//
//  Created by 김민재 on 2023/07/01.
//

import UIKit

class MonthCollectionViewCell: UICollectionViewCell {

    static let identifier = "MonthCollectionViewCell"

    var monthText: String? {
        didSet {
            monthLabel.text = monthText
        }
    }

    private let monthLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isSelected: Bool {
        didSet {
            monthLabel.font = isSelected
            ? .boldSystemFont(ofSize: 14)
            : .systemFont(ofSize: 10)
        }
    }

    private func setLayout() {
        contentView.addSubview(monthLabel)
        monthLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}
