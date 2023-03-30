//
//  TableViewController.swift
//  weakEx
//
//  Created by 김민재 on 2023/03/30.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

    deinit {
        print("TableViewController deinit ❌ ")
    }
    

}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

extension TableViewController: TableViewCellProtocol {
    func buttonDidTap() {
        present(SecondViewController(), animated: true)
    }
}
