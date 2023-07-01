//
//  HomeTableViewHeaderView.swift
//  NetEx
//
//  Created by 김민재 on 2023/07/01.
//

import UIKit

class HomeTableViewHeaderView: UITableViewHeaderFooterView {

    static let identifier = "HomeTableViewHeaderView"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
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
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }

    func configureCell(_ text: String?) {
        titleLabel.text = text
    }

}
