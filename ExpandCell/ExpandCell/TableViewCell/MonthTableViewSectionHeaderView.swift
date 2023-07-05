//
//  MonthTableViewSectionHeaderView.swift
//  ExpandCell
//
//  Created by 김민재 on 2023/07/03.
//

import UIKit

class MonthTableViewSectionHeaderView: UITableViewHeaderFooterView {

    var monthText: String? {
        didSet {
            monthLabel.text = monthText
        }
    }

    private let monthLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        self.addSubview(monthLabel)
        monthLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(70)
        }
    }

}
