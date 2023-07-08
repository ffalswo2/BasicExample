//
//  ViewController.swift
//  NaviEx
//
//  Created by 김민재 on 2023/07/09.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray

        setNavigation()
    }

    private func setNavigation() {
        // 이거 다운 캐스팅밖에 답 없을까
        guard let navi = self.navigationController as? CustomNavigationController else { return }
        navi.setType(type: .main)
        navi.rightFirstIconTapped = {
            print("right First icon tapped ! ")
        }
        navi.rightSecondIconTapped = {
            print("right second icon tapped ! ")
        }
    }


}

