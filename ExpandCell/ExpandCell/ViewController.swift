//
//  ViewController.swift
//  ExpandCell
//
//  Created by 김민재 on 2023/07/01.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private let monthCount = 10

    private let monthCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = .yellow
        return cv
    }()

    private let curriCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = .brown
        cv.isPagingEnabled = true
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setCollectionViews()
        view.backgroundColor = .white
    }

    private func setLayout() {
        self.view.addSubview(monthCollectionView)
        self.view.addSubview(curriCollectionView)

        monthCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)

            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
        curriCollectionView.snp.makeConstraints { make in
            make.top.equalTo(monthCollectionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func setCollectionViews() {
        monthCollectionView.delegate = self
        monthCollectionView.dataSource = self
        monthCollectionView.register(MonthCollectionViewCell.self, forCellWithReuseIdentifier: MonthCollectionViewCell.identifier)

        curriCollectionView.delegate = self
        curriCollectionView.dataSource = self
        curriCollectionView.register(CurriCollectionViewCell.self, forCellWithReuseIdentifier: CurriCollectionViewCell.identifier)
    }


}



extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let currItem = curriCollectionView.indexPathsForVisibleItems.first?.item else { return }

        if collectionView == monthCollectionView {
            let toIndexPath = IndexPath(item: indexPath.item, section: 0)
            let direction: UICollectionView.ScrollPosition = currItem < toIndexPath.item
            ? .left
            : .right

            curriCollectionView.scrollToItem(at: toIndexPath, at: direction, animated: true)
            return
        }
    }

}

extension ViewController: UICollectionViewDelegateFlowLayout {

}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == monthCollectionView {
            return CGSize(
                width: UIScreen.main.bounds.width / 8, height: 80)
        }

        return CGSize(
            width: UIScreen.main.bounds.width,
            height: curriCollectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 8개월
        return monthCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 개월 컬뷰
        if collectionView == monthCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthCollectionViewCell.identifier, for: indexPath) as? MonthCollectionViewCell else { return .init() }
            cell.monthText = "\(indexPath.item + 1)개월"
            return cell
        }

        // 커리큘럼 컬뷰
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurriCollectionViewCell.identifier, for: indexPath) as? CurriCollectionViewCell else { return .init() }



        return cell
    }


}
