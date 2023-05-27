//
//  StroageViewController.swift
//  SOPT32-Seminar-3
//
//  Created by 김민재 on 2023/05/27.
//

import UIKit

final class StorageViewController: UIViewController {
    private let realm = RealmService()
    private let tableView = UITableView()

    private var dummy: [PostDTO] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }


    private func setStyle() {
        view.backgroundColor = .white

        tableView.do {
            $0.register(
                CarrotTableViewCell.self,
                forCellReuseIdentifier: CarrotTableViewCell.className
            )
            $0.rowHeight = 120
            $0.delegate = self
            $0.dataSource = self
        }
    }

    private func setLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setStyle()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let result = realm.getPosts()
        let posts = realm.convertToStoragePost(input: result)
        self.dummy = posts
    }
}

//
//  CarrotViewController.swift
//  SOPT32-Seminar-3
//
//  Created by 김민재 on 2023/04/22.
//




extension StorageViewController: UITableViewDelegate {

}

extension StorageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarrotTableViewCell.className, for: indexPath) as? CarrotTableViewCell else { return UITableViewCell() }

        cell.configureCell(dummy[indexPath.item])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummy.count
    }
}
