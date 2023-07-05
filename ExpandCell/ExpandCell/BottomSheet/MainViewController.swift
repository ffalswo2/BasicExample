//
//  MainViewController.swift
//  ExpandCell
//
//  Created by 김민재 on 2023/07/04.
//

import UIKit

class MainViewController: UIViewController {

    private let bottomSheetView = BottomSheetView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        // Do any additional setup after loading the view.
    }

    private func setLayout() {
        self.view.addSubview(bottomSheetView)

        bottomSheetView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(300)
            make.leading.trailing.equalToSuperview()
        }
    }

}

//            make.bottom.equalTo(view.safeAreaLayoutGuide)
