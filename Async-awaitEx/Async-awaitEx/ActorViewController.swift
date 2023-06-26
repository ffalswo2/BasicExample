//
//  ActorViewController.swift
//  Async-awaitEx
//
//  Created by 김민재 on 2023/06/25.
//

import UIKit

class ActorViewController: UIViewController {

    var userInfo = UserInfo()

    override func viewDidLoad() {
        super.viewDidLoad()

        for _ in 0..<20 {
            concurAddName()
        }


        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            Task {
                print("names", await self.userInfo.names)
                print("count", await self.userInfo.names.count)
            }
        }
    }

    func concurAddName() {
        DispatchQueue.global().async {
            Task {
                await self.userInfo.appendName()
            }
        }
    }

}

actor UserInfo {
    nonisolated let myName = "kim"
    nonisolated var age: Int {
        return 20
    }

    nonisolated var age = 20

    var names = [String]()

    func appendName() {
        names.append("KIM")
        print("append done !")
    }
}
