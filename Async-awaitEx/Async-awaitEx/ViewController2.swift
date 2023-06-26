//
//  ViewController2.swift
//  Async-awaitEx
//
//  Created by 김민재 on 2023/06/25.
//

import UIKit

enum MyError: String, Error {
    case myType1 = "타입1"
    case myType2 = "타입2"
}

class ViewController2: UIViewController {

    var myTask: Task<UInt64, Error>?

    override func viewDidLoad() {
        super.viewDidLoad()

        myTask = Task {
            async let sec3 = asyncWork(sec: 3)
            async let sec1 = asyncWork(sec: 1)
            async let sec2 = asyncWork(sec: 2)

            let sec4 = await asyncWork2(sec: 5)
            switch sec4 {
            case .success(let success):
                print("success", success)
            case .failure(let failure):
                print("failure", failure)
            }

            var sum: UInt64 = 0
            do {
                sum = try await sec1 + sec2 + sec3
            } catch {
                throw MyError.myType1
            }

            guard myTask?.isCancelled == false else { return 0 }

            do {
                try Task.checkCancellation()
            } catch {
                throw MyError.myType2
            }




            print(sum)
            print("finish")
            return sum
        }

        Task {
            do {
                let taskValue = try await myTask?.result.get()
                print(taskValue)
            } catch let error as MyError {
                print(error.rawValue)

            }
        }

        pressCancelButton()
    }

    func pressCancelButton() {
        myTask?.cancel()
    }
    

    func asyncWork(sec: UInt64) async throws -> UInt64 {
        do {
            try await Task.sleep(nanoseconds: 1000 * 1000 * 1000 * sec)
        } catch {
            print(error)
            throw error
        }

        print(sec)
        return sec
    }

    func asyncWork2(sec: UInt64) async -> Result<UInt64, MyError> {
        do {
            try await Task.sleep(nanoseconds: 1000 * 1000 * 1000 * sec)
        } catch {
            print(error)
            return .failure(.myType2)
        }

        print(sec)
        return .success(sec)
    }



}
