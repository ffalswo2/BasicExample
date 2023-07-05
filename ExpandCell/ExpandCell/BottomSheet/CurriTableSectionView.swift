//
//  CurriTableSectionView.swift
//  ExpandCell
//
//  Created by 김민재 on 2023/07/04.
//

import UIKit

class CurriTableSectionView: UITableViewHeaderFooterView {

    static let identifier = "CurriTableSectionView"

    var monthText: String? {
        didSet {
            monthLabel.text = monthText
        }
    }

    private let monthLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)

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
            make.bottom.equalToSuperview().offset(30)
            make.leading.equalToSuperview().inset(10)
        }
        
    }

}
