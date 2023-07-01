//
//  NewHotViewController.swift
//  NetEx
//
//  Created by 김민재 on 2023/06/29.
//

import UIKit

class NewHotViewController: UIViewController {

    private let newHotTableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = UITableView.automaticDimension
        tv.backgroundColor = .black
        tv.estimatedRowHeight = 400
        return tv
    }()

    var movieModel: MovieModel? {
        didSet {
            DispatchQueue.main.async {
                self.newHotTableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setTableView()
        networkRequest()
        view.backgroundColor = .black
//        self.navigationItem.title = "NEW & HOT"
        

    }

    private func setLayout() {
        self.view.addSubview(newHotTableView)
        newHotTableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }

    private func setTableView() {
        newHotTableView.register(NewHotTableViewCell.self, forCellReuseIdentifier: NewHotTableViewCell.identifier)

        newHotTableView.register(DateHeaderView.self, forHeaderFooterViewReuseIdentifier: DateHeaderView.identifier)
        newHotTableView.delegate = self
        newHotTableView.dataSource = self
    }

}

extension NewHotViewController {
    private func networkRequest() {
        NetworkLayer.request(mediaType: .movie) { movieModel in
            self.movieModel = movieModel
        }
    }
}

extension NewHotViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // visible cell
        guard let visibleCells = newHotTableView.visibleCells as? [NewHotTableViewCell] else { return }

        guard let firstCell = visibleCells.first else { return }

        if visibleCells.count == 1 {
            // 하나밖에 없다? 그럼 하나만 있는거 바로 play시키면 된다.
            firstCell.playPlayer()
            return
        }

        let secondCell = visibleCells[1]

        // position convert
        let firstCellPositionY = newHotTableView.convert(firstCell.frame.origin, to: self.view).y
        print("first : ", firstCellPositionY)

        let secondCellPositionY = newHotTableView.convert(secondCell.frame.origin, to: self.view).y
        print("second : ", secondCellPositionY)

        if firstCellPositionY > 50 {
            // first cell play
            firstCell.playPlayer()

            // 첫번째셀 제외 나머지셀은 정지
            var leftCells = visibleCells
            leftCells.removeFirst()

            leftCells.forEach { cell in
                cell.stopPlayer()
            }

        } else {
            // 첫번째셀 어느정도 가려짐
            // 두번째 셀 재생
            secondCell.playPlayer()

            var leftCells = visibleCells
            leftCells.remove(at: 1)
            leftCells.forEach { cell in
                // cell stop
                cell.stopPlayer()
            }
        }

    }
}

extension NewHotViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: DateHeaderView.identifier) as? DateHeaderView else { return UIView() }

        if let isoDateString = movieModel?.results[section].releaseDate {
            let formatter = ISO8601DateFormatter()
            if let date = formatter.date(from: isoDateString) {

                let myFormatter = DateFormatter()
                myFormatter.dateFormat = "M월\ndd"
                let dateString = myFormatter.string(from: date)

                let attrtibutedString = NSMutableAttributedString(string: myFormatter.string(from: date))


                let monthRange = NSRange(location: 0, length: dateString.count - 2)
                let dayRange = NSRange(location: dateString.count - 2, length: 2)


                attrtibutedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: monthRange)
                attrtibutedString.addAttribute(.foregroundColor, value: UIColor.lightGray, range: monthRange)

                attrtibutedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: dayRange)
                attrtibutedString.addAttribute(.foregroundColor, value: UIColor.white, range: dayRange)


                headerView.dateAttributeString = attrtibutedString
            }
        }


        return headerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return movieModel?.resultCount ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewHotTableViewCell.identifier, for: indexPath) as? NewHotTableViewCell else { return UITableViewCell() }
        guard let model = self.movieModel?.results[indexPath.section] else { return UITableViewCell() }
        cell.movieResult = model
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
}
