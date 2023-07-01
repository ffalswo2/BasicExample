//
//  NewHotTableViewCell.swift
//  NetEx
//
//  Created by 김민재 on 2023/07/01.
//

import UIKit
import AVKit

class NewHotTableViewCell: UITableViewCell {

    static let identifier = "NewHotTableViewCell"

    private let baseContainerView: UIView = {
        let baseView = UIView()
        baseView.backgroundColor = .black
        return baseView
    }()

    private let movieContainerView: UIView = {
        let movieView = UIView()
        movieView.backgroundColor = .black
        return movieView
    }()

    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "photo")
        imageView.clipsToBounds = true
        return imageView
    }()

    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()

    private let shortDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    private var player = AVPlayer()
    private var playerLayer = AVPlayerLayer()

    var movieResult: MovieResult? {
        didSet {
            self.configureCell()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: nil)
        setLayout()
        setPlayerLayout()
        contentView.backgroundColor = .black
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setPlayerLayout() {
        movieContainerView.layer.addSublayer(playerLayer)
        playerLayer.frame = CGRect(
            x: 0, y: 0,
            width: UIScreen.main.bounds.width - 50, height: 200)
    }

    private func setLayout() {
        self.contentView.addSubview(baseContainerView)
        baseContainerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(50)
            make.top.trailing.bottom.equalToSuperview()
        }


        [movieContainerView, thumbnailImageView, dateLabel, titleLabel, shortDescriptionLabel].forEach {
            baseContainerView.addSubview($0)
        }

        movieContainerView.addSubview(coverImageView)

        coverImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        movieContainerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }

        thumbnailImageView.snp.makeConstraints { make in
            make.top.equalTo(movieContainerView.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.height.equalTo(80)
            make.width.equalTo(50)
        }

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }

        shortDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().inset(30)
            make.trailing.equalToSuperview().inset(20)
        }
    }

    private func configureCell() {
        self.titleLabel.text = movieResult?.trackName
        self.shortDescriptionLabel.text = movieResult?.shortDescription


        let isoFormatter = ISO8601DateFormatter()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let dateString = movieResult?.releaseDate,
              let date = isoFormatter.date(from: dateString)
        else { return }

        self.dateLabel.text = formatter.string(from: date)

        setPlayerURL()
        setThumbnail()
        setCoverImage()
    }

    private func setPlayerURL() {
        guard let urlString = movieResult?.previewUrl,
              let url = URL(string: urlString)
        else { return }

        self.player = AVPlayer(url: url)
        self.playerLayer.player = self.player
        self.player.volume = 0
        
        self.player.play()
    }

    private func setCoverImage() {
        guard let artworkURL = movieResult?.artworkUrl else { return }

        NetworkLayer.request(urlString: artworkURL) { image in
            DispatchQueue.main.async {
                self.coverImageView.image = image
            }
        }
    }

    private func setThumbnail() {
        guard let artworkURL = movieResult?.artworkUrl else { return }

        NetworkLayer.request(urlString: artworkURL) { image in
            DispatchQueue.main.async {
                self.thumbnailImageView.image = image
            }
        }
    }

    func playPlayer() {
        if self.player.timeControlStatus != .playing {
            self.player.play()
            coverImageView.isHidden = true
        }
    }

    func stopPlayer() {
        self.player.pause()
        if self.player.currentTime().seconds > 1 {
            coverImageView.isHidden = true
        } else {
            coverImageView.isHidden = false
        }
    }

}
