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

    // Network
    private var weekArticles = Curriculum.dummy()

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

    private let curriTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setCollectionViews()
        setTableView()
        view.backgroundColor = .white
    }

    private func setLayout() {
        self.view.addSubview(monthCollectionView)
//        self.view.addSubview(curriCollectionView)
        self.view.addSubview(curriTableView)

        monthCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)

            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }

        curriTableView.snp.makeConstraints { make in
            make.top.equalTo(monthCollectionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
//        curriCollectionView.snp.makeConstraints { make in
//            make.top.equalTo(monthCollectionView.snp.bottom)
//            make.leading.trailing.equalToSuperview()
//            make.bottom.equalTo(view.safeAreaLayoutGuide)
//        }

    }

    private func setCollectionViews() {
        monthCollectionView.delegate = self
        monthCollectionView.dataSource = self
        monthCollectionView.register(MonthCollectionViewCell.self, forCellWithReuseIdentifier: MonthCollectionViewCell.identifier)

//        curriCollectionView.delegate = self
//        curriCollectionView.dataSource = self
//        curriCollectionView.register(CurriCollectionViewCell.self, forCellWithReuseIdentifier: CurriCollectionViewCell.identifier)
    }

    private func setTableView() {
        curriTableView.delegate = self
        curriTableView.dataSource = self
        // register table view cell
        curriTableView.register(WeekTableViewCell.self, forCellReuseIdentifier: WeekTableViewCell.identifier)

    }


}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previous = weekArticles[indexPath.row]
        weekArticles[indexPath.row] = Curriculum(week: previous.week, description: previous.description, isDescHidden: !previous.isDescHidden)
        tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: indexPath.section)], with: UITableView.RowAnimation.automatic)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // scroll 내리다가 visible cell position
        guard let visibleCells = curriTableView.visibleCells as? [WeekTableViewCell],
              let firstCell = visibleCells.first
        else { return }

//        let firstCellOriginY = curriTableView.convert(firstCell.frame.origin, to: self.view).y

//        print("first cell origin Y : ", firstCell.frame.origin.y)

        guard let indexPath = curriTableView.indexPathForRow(at: firstCell.frame.origin) else { return }
        print("section : \(indexPath.section), row : \(indexPath.row)")

        let newIndexPath = IndexPath(item: indexPath.section, section: 0)

        // curriTableView.indexPathsForVisibleRows 이거쓰면 위에 메서드 두줄 함축 가능하네?? 개꿀ㅋㅋ




        guard let cell = monthCollectionView.cellForItem(at: newIndexPath) as? MonthCollectionViewCell else { return }
        guard let visibleCells = monthCollectionView.visibleCells as? [MonthCollectionViewCell] else { return }
        cell.isSelected = true
        let otherCells = visibleCells.filter { $0 != cell }
        otherCells.forEach { cell in
            cell.isSelected = false
        }

        // scrollToItem



        
    }

}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // 개월 수
        return monthCount
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 한 개월에 해당하는 주차 수
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 커리큘럼 expandable cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeekTableViewCell.identifier, for: indexPath) as? WeekTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        let curri = weekArticles[indexPath.row]
        cell.curriData = curri
        cell.isLast = indexPath.row == weekArticles.count - 1
        return cell
    }


}

// CollectionView는 위에 개월 표시에 해당하는 CollectionView

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 개월 누르면 해당 TableView Section으로 scroll 되야함.
        guard let currItem = curriCollectionView.indexPathsForVisibleItems.first?.item else { return }




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
        // 개월수
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
