//
//  HomeViewController.swift
//  NetEx
//
//  Created by 김민재 on 2023/06/29.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {

    private let tableView: UITableView = {
        let tv = UITableView()
        // default: automatic
        tv.contentInsetAdjustmentBehavior = .never
        tv.separatorStyle = .none
        tv.backgroundColor = .black
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setLayout()
        setTableView()
    }

    private func setStyle() {
        view.backgroundColor = .gray
    }

    private func setLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func setTableView() {
        let headerView = HomeTableHeaderView()
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 400)
        tableView.tableHeaderView = headerView
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.register(HomeTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: HomeTableViewHeaderView.identifier)

    }
}

extension HomeViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let homeNavi = self.navigationController as? HomeNavigationViewController else { return }
        let area: CGFloat = 100
        let alpha = min(1, scrollView.contentOffset.y / area)
        homeNavi.effectViewAlpha = alpha
    }
}

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeTableViewHeaderView.identifier) as? HomeTableViewHeaderView else { return UIView() }
        headerView.configureCell(MediaType(rawValue: section)?.title)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return MediaType.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }

        guard let type = MediaType(rawValue: indexPath.section) else { return UITableViewCell() }
        cell.requestWithMediaType(type: type)

        return cell
    }
}
