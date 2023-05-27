//
//  TitleDetailCollectionViewCell.swift
//  DiffableExample
//
//  Created by 김민재 on 2023/05/15.
//

import UIKit

class TitleDetailCollectionViewCell: UICollectionViewCell {

    static let identifier = "DetailCollectionViewCell"

    private let titleLabel = UILabel().then {
        $0.text = "제목 *"
        $0.applyColor(to: "*", with: .red)
    }

    private let textField = UITextField().then {
        $0.backgroundColor = .blue
    }

    private let descriptionLabel = UILabel().then {
        $0.text = "설명"
    }

    private let textView = UITextView().then {
        $0.backgroundColor = .brown
    }



    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        [titleLabel, textField, descriptionLabel, textView].forEach {
            contentView.addSubview($0)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(13)
            make.leading.equalToSuperview().inset(27)
        }

        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(24)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(21)
            make.leading.equalTo(titleLabel)
        }

        textView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(textField)
            make.bottom.equalToSuperview().inset(25)
        }
    }

}


extension UILabel {
    func applyColor(to targetString: String, with color: UIColor) {
      if let labelText = self.text, labelText.count > 0 {
        let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(.foregroundColor,
                                      value: color,
                                      range: (labelText as NSString).range(of: targetString))
        attributedText = attributedString
      }
    }
}
