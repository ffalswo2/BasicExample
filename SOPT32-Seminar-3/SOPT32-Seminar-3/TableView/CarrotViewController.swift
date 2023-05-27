//
//  CarrotViewController.swift
//  SOPT32-Seminar-3
//
//  Created by 김민재 on 2023/04/22.
//

import UIKit

final class CarrotViewController: BaseViewController {

    private let realm = RealmService()
    private let tableView = UITableView()

    private let dummy = Carrot.dummy()


    override func setStyle() {
        print(dummy)
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

    override func setLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}



extension CarrotViewController: UITableViewDelegate {

}

extension CarrotViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarrotTableViewCell.className, for: indexPath) as? CarrotTableViewCell else { return UITableViewCell() }

        cell.configureCell(dummy[indexPath.item])
        cell.closure = { [weak self] isSelected in
            guard let self else { return }
            let post = PostDTO(
                id: self.dummy[indexPath.item].id,
                img: "hypeBoy",
                name: self.dummy[indexPath.item].product,
                location: self.dummy[indexPath.item].place,
                date: self.dummy[indexPath.item].time,
                price: self.dummy[indexPath.item].price.description,
                status: self.dummy[indexPath.item].tradeStatus.title
            )

            if isSelected {
                self.realm.deletePost(dto: post)
                cell.button.isSelected.toggle()
                return
            }

            guard self.realm.checkUniquePost(input: post) else { return }
            self.realm.addPost(item: post)
            cell.button.isSelected.toggle()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummy.count
    }
}
