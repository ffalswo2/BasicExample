//
//  ViewController.swift
//  InfiniteCarousel
//
//  Created by 김민재 on 2023/05/01.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    var images: [UIImage] = [
        UIImage(named: "1")!, // 최강 야구
        UIImage(named: "2")!, // 너의 이름은
        UIImage(named: "3")!, // 스즈메
        UIImage(named: "4")! // 귀칼
    ]



    enum Size {
        static let screenWidth = UIScreen.main.bounds.width
    }

    private let carouselCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentOffset = .zero
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true // ?
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.isPagingEnabled = true
        return collectionView
    }()

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: .zero)
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .gray
        pageControl.backgroundStyle = .minimal
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black


        images.insert(images[images.count - 1], at: 0)
        images.append(images[1])

        setLayout()

        carouselCollectionView.delegate = self
        carouselCollectionView.dataSource = self

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        carouselCollectionView.setContentOffset(
            .init(x: Size.screenWidth, y: carouselCollectionView.contentOffset.y), animated: false)
    }

    private func setLayout() {
        view.addSubview(carouselCollectionView)
        view.addSubview(pageControl)
        carouselCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width * 230 / 151)
        }
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(carouselCollectionView.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }

    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Size.screenWidth, height: UIScreen.main.bounds.width * 230 / 151)
    }
}

extension ViewController: UICollectionViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //TODO: - Timer로 자동 이동

//        let count = images.count
//
//
//        // 4 1 2 3 4 1
        if scrollView.contentOffset.x == 0 { // 첫번째(4)가 보이면 4번째 index의 4로 이동시키기
            scrollView.setContentOffset(.init(x: Size.screenWidth * 4, y: scrollView.contentOffset.y), animated: false)
        }
        else if scrollView.contentOffset.x == Size.screenWidth * 5 { //마지막 1이 보이면 1번째 index의 1로 이동
            scrollView.setContentOffset(.init(x: Size.screenWidth, y: scrollView.contentOffset.y), animated: false)
        }
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX) - 1
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell
        else { return UICollectionViewCell() }

        cell.configureCell(image: images[indexPath.item])
        return cell
    }
}
