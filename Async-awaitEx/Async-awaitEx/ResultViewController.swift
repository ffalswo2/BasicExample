//
//  ResultViewController.swift
//  Async-awaitEx
//
//  Created by 김민재 on 2023/06/26.
//

import UIKit

enum URLError: Error, CustomStringConvertible {
    case invalidURL
    case timeout

    var description: String {
        switch self {
        case .invalidURL:
            return "URL invalid"
        case .timeout:
            return "타임 아웃"
        }
    }
}

class ResultViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            try requestNetwork()
        } catch {
            print(error)
        }

        let myResult = requestNetworkWithResult()
        switch myResult {
        case .success(let success):
            print(success)
        case .failure(let failure):
            print(failure)
        }

        if case let Result.failure(str) = requestNetworkWithResult() {
            print(str)
        }
    }

    var isSuccess = false

    func requestNetwork() throws -> String {
        if isSuccess {
            return "Sucess String"
        }
        throw URLError.invalidURL
    }

    func requestNetworkWithResult() -> Result<String, URLError> {
        if isSuccess {
            return .success("success string !")
        }
        return .failure(.invalidURL)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

enum MyResult<T, E> where E: Error {
    case success(T)
    case failure(E)
}
