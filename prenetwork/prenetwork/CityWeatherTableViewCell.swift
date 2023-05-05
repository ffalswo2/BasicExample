//
//  CityWeatherTableViewCell.swift
//  prenetwork
//
//  Created by 김민재 on 2023/05/06.
//

import UIKit

class CityWeatherTableViewCell: UITableViewCell {

    static let identifier = "CityWeatherTableViewCell"

    private let tempLabel = UILabel()
    private let weatherLabel = UILabel()
    private let maxminTempLabel = UILabel()

    private lazy var stackView = UIStackView(arrangedSubviews: [
        tempLabel,
        weatherLabel,
        maxminTempLabel
    ])

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell() {
        
    }

}
