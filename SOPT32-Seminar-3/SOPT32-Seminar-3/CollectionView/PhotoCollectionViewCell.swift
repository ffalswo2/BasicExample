//
//  PhotoCollectionViewCell.swift
//  SOPT32-Seminar-3
//
//  Created by 김민재 on 2023/04/22.
//

import UIKit
import SnapKit
import Then


final class PhotoCollectionViewCell: UICollectionViewCell {

    let photoImage = UIImageView()
    let button = UIButton()

    var isTapped: Bool = false {
        didSet {
            updateButton()
        }
    }
    
    var handler: (() -> (Void))?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setStyle()
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setStyle() {
        button.do {
            $0.tintColor = .white
            $0.addTarget(self,
                         action: #selector(heartButtonTapped),
                         for: .touchUpInside)
        }
    }

    func setLayout() {

        contentView.addSubview(photoImage)
        contentView.addSubview(button)

        photoImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        button.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(5)
            $0.size.equalTo(30)
        }
    }

    func configureCell(_ photo: Photo) {
        photoImage.image = photo.image
        isTapped = photo.heartTapped
    }

    @objc
    func heartButtonTapped() {
        handler?()
    }

    func updateButton() {
        let image = isTapped ? "heart.fill" : "heart"
        button.setImage(UIImage(systemName: image), for: .normal)
    }
    
}
