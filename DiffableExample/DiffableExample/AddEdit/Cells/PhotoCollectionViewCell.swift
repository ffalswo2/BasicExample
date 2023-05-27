//
//  PhotoCollectionViewCell.swift
//  DiffableExample
//
//  Created by 김민재 on 2023/05/15.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    static let identifier = "PhotoCollectionViewCell"

    private let imageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .blue
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setStyle() {
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }

    private func setLayout() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configureImageView(color: UIColor) {
        imageView.backgroundColor = color
    }
    
}
