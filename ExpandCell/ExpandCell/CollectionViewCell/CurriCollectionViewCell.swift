//
//  CurriCollectionViewCell.swift
//  ExpandCell
//
//  Created by 김민재 on 2023/07/01.
//

import UIKit

class CurriCollectionViewCell: UICollectionViewCell {


    // 총 임신 주차
    private let weekCount = 40

    static let identifier = "CurriCollectionViewCell"

    // Network
    private var weekArticles = Curriculum.dummy()

    private let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        return tv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setLayout() {
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        // tableview register cell
        tableView.register(WeekTableViewCell.self, forCellReuseIdentifier: WeekTableViewCell.identifier)
    }
    
}

extension CurriCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previous = weekArticles[indexPath.row]
        weekArticles[indexPath.row] = Curriculum(week: previous.week, description: previous.description, isDescHidden: !previous.isDescHidden)
        tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: UITableView.RowAnimation.automatic)
    }
}


extension CurriCollectionViewCell: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekArticles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeekTableViewCell.identifier, for: indexPath) as? WeekTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        let curri = weekArticles[indexPath.row]
        cell.curriData = curri
        cell.isLast = indexPath.row == weekArticles.count - 1
        return cell
    }


}
