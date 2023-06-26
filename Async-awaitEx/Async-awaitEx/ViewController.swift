//
//  ViewController.swift
//  Async-awaitEx
//
//  Created by 김민재 on 2023/06/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        start()
    }

    func simpleWork() {
        print("doing simple work")
    }

    func someWork() async -> Int {
        try? await Task.sleep(nanoseconds: 1000 * 1000 * 1000 * 3)
        return 10
    }

    func start() {

        Task {
            print("start !")
            let num = await someWork()
            print(num)
            print("finish !")
        }

//        Task {
//            print("concurr 1")
//            print("concurr 2")
//        }

        simpleWork()
    }
}

