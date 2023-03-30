//
//  ViewController.swift
//  weakEx
//
//  Created by 김민재 on 2023/03/30.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func nextButtonDidTap(_ sender: Any) {
        guard let tableViewController = UIStoryboard(name: "Table", bundle: nil).instantiateViewController(withIdentifier: "TableViewController") as? TableViewController else {
            return
        }

        self.navigationController?.pushViewController(tableViewController, animated: true)
    }
}

