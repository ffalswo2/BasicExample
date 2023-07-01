//
//  HomeTableHeaderView.swift
//  NetEx
//
//  Created by 김민재 on 2023/06/29.
//

import UIKit

class HomeTableHeaderView: UIView {

    private let posterImageView: UIImageView = {
        let image = UIImage(named: "topgun")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        self.addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
