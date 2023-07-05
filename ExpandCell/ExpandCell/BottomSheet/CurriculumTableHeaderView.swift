//
//  CurriculumTableHeaderView.swift
//  ExpandCell
//
//  Created by 김민재 on 2023/07/04.
//

import UIKit

class CurriculumTableHeaderView: UIView {

    private let curriculumLabel: UILabel = {
        let label = UILabel()
        label.text = "커리큘럼"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        self.addSubview(curriculumLabel)
        curriculumLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(15)
        }
    }

}
