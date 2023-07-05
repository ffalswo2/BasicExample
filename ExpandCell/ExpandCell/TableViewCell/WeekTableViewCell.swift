//
//  WeekTableViewCell.swift
//  ExpandCell
//
//  Created by 김민재 on 2023/07/01.
//

import UIKit

class WeekTableViewCell: UITableViewCell {

    static let identifier = "WeekTableViewCell"

    var curriData: Curriculum? {
        didSet {
            self.configCell()
        }
    }

    var isLast: Bool = false {
        didSet {
            self.lineView.isHidden = isLast
        }
    }

    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.backgroundColor = .lightGray
        return view
    }()

    private let circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()

    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()

    private let weekLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    private let seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체보기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isHidden = true
        return imageView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            weekLabel, thumbnailImageView, descriptionLabel
        ])
        stack.axis = .vertical
        stack.alignment = .leading

        return stack
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: nil)
        setLayout()
    }

    override func draw(_ rect: CGRect) {
        circleView.layer.cornerRadius = circleView.frame.width / 2
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        contentView.addSubview(containerView)
        contentView.addSubview(circleView)
        contentView.addSubview(lineView)
        containerView.addSubview(stackView)
//        [weekLabel, seeAllButton, thumbnailImageView, descriptionLabel].forEach {
//            containerView.addSubview($0)
//        }



        containerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(90)
            make.top.bottom.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
        }

        circleView.snp.makeConstraints { make in
            make.top.equalTo(containerView)
            make.trailing.equalTo(containerView.snp.leading).offset(-10)
            make.size.equalTo(24)
        }

        lineView.snp.makeConstraints { make in
            make.centerX.equalTo(circleView)
            make.top.equalTo(circleView.snp.bottom)
            make.width.equalTo(3)
            make.bottom.equalToSuperview()
        }

        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }

//        weekLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(5)
//            make.leading.equalToSuperview().inset(10)
//        }

//        seeAllButton.snp.makeConstraints { make in
//            make.centerY.equalTo(weekLabel)
//            make.trailing.equalToSuperview().inset(10)
//        }

//        thumbnailImageView.snp.makeConstraints { make in
//            make.top.equalTo(weekLabel.snp.bottom).offset(5)
//            make.leading.equalTo(weekLabel)
//            make.trailing.equalTo(seeAllButton.snp.trailing)
//        }
//
//        descriptionLabel.snp.makeConstraints { make in
//            make.top.equalTo(thumbnailImageView.snp.bottom)
//            make.leading.equalTo(weekLabel)
//            make.trailing.equalTo(seeAllButton)
//            make.bottom.equalToSuperview()
//        }
    }

    private func configCell() {
        guard let curriData else { return }
        weekLabel.text = "Week \(curriData.week)"
        descriptionLabel.text = curriData.description
        thumbnailImageView.isHidden = curriData.isDescHidden
        descriptionLabel.numberOfLines = curriData.isDescHidden ? 1 : 0
        
    }

    func setLastCell() {
        lineView.isHidden = true
    }

}
