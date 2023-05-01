//
//  CollectionViewCell.swift
//  InfiniteCarousel
//
//  Created by 김민재 on 2023/05/02.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let identifier = "CollectionViewCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        configureCell()
    }


    private func setLayout() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configureCell(image: UIImage? = nil) {
        imageView.image = image
    }
}
