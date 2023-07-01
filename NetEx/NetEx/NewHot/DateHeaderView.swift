//
//  DateHeaderView.swift
//  NetEx
//
//  Created by 김민재 on 2023/07/01.
//

import UIKit

class DateHeaderView: UITableViewHeaderFooterView {

    static let identifier = "DateHeaderView"

    var dateAttributeString: NSMutableAttributedString? {
        didSet {
            dateLabel.attributedText = dateAttributeString
        }
    }

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .black
        label.numberOfLines = 0
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(50)
            make.leading.equalToSuperview().inset(5)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
