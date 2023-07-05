//
//  BottomSheetView.swift
//  ExpandCell
//
//  Created by 김민재 on 2023/07/04.
//

import UIKit

class BottomSheetView: UIView {



    private let monthCount = 10

    // Network
    private var weekArticles = Curriculum.dummy()

//    private let curriCollectionView: UICollectionView = {
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.scrollDirection = .horizontal
//        flowLayout.minimumLineSpacing = 0
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
//        cv.backgroundColor = .brown
//        cv.isPagingEnabled = true
//        return cv
//    }()

    private let rootView: UIView = {
      let view = UIView()
      view.layer.cornerRadius = 20
        view.backgroundColor = .white
      view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
      return view
    }()

    private let curriTableView: UITableView = {
        let tableView = UITableView()
        let headerView = CurriculumTableHeaderView()
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20)
        tableView.separatorStyle = .none
        tableView.tableHeaderView = headerView

        // make section headper padding Zero
        tableView.sectionHeaderTopPadding = 0
        return tableView
    }()

    private let grabberView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 5
        view.layer.cornerCurve = .continuous
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setTableView()
        setPanGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        self.addSubview(rootView)
        rootView.addSubview(grabberView)
        rootView.addSubview(curriTableView)
//        self.addSubview(grabberView)
//        self.addSubview(curriTableView)

        rootView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        grabberView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(5)
        }

        curriTableView.snp.makeConstraints { make in
            make.top.equalTo(grabberView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    private func setTableView() {
        curriTableView.delegate = self
        curriTableView.dataSource = self
        // register table view cell
        curriTableView.register(WeekTableViewCell.self, forCellReuseIdentifier: WeekTableViewCell.identifier)
        curriTableView.register(CurriTableSectionView.self, forHeaderFooterViewReuseIdentifier: CurriTableSectionView.identifier)

    }

}


extension BottomSheetView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previous = weekArticles[indexPath.row]
        weekArticles[indexPath.row] = Curriculum(week: previous.week, description: previous.description, isDescHidden: !previous.isDescHidden)
        tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: indexPath.section)], with: UITableView.RowAnimation.automatic)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        guard let visibleCells = curriTableView.visibleCells as? [WeekTableViewCell],
              let firstCell = visibleCells.first
        else { return }

//        let firstCellOriginY = curriTableView.convert(firstCell.frame.origin, to: self.view).y

//        print("first cell origin Y : ", firstCell.frame.origin.y)

        guard let indexPath = curriTableView.indexPathForRow(at: firstCell.frame.origin) else { return }
        print("section : \(indexPath.section), row : \(indexPath.row)")

        let newIndexPath = IndexPath(item: indexPath.section, section: 0)

        // scroll 내리다가 visible cell position
        // curriTableView.indexPathsForVisibleRows 이거쓰면 위에 메서드 두줄 함축 가능하네?? 개꿀ㅋㅋ



    }

}

extension BottomSheetView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = CurriTableSectionView()
        sectionHeaderView.monthText = "\(section + 1)개월"
        return sectionHeaderView
    }

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


extension BottomSheetView {
    private func setPanGesture() {
        let gesture = UIPanGestureRecognizer(target: self,
                                             action: #selector(handlePan))
        self.addGestureRecognizer(gesture)
    }
}


extension BottomSheetView {
    @objc
    private func handlePan(_ sender: UIPanGestureRecognizer) {
        let viewTranslation = sender.translation(in: self)
        print("view Translation : ", viewTranslation.y)
//        viewVelocity = sender.translation(in: self)
//        print(self.viewVelocity)
        switch sender.state {
        case .changed:
            if viewTranslation.y < 0 {
                self.transform = CGAffineTransform(translationX: 0, y: viewTranslation.y)
            }
        case .ended:
            let bottomSheetView = self.frame.height
            let screenHeight = UIScreen.main.bounds.height
            print("screen height : ", screenHeight)
            print("bottom sheet view : ", bottomSheetView)
            let standardHeight = (screenHeight - bottomSheetView) / 2

            print("abs viewTranslation y : ", -viewTranslation.y)
            print(standardHeight)

            if -viewTranslation.y < standardHeight {
                UIView.animate(withDuration: 0.3, delay: 0) {
                    self.transform = .identity
                }
            } else {
                UIView.animate(withDuration: 0.3, delay: 0) {
                    self.transform = CGAffineTransform(translationX: 0, y: screenHeight - 100)
                }
            }
        default:
            break
        }


    }
}
