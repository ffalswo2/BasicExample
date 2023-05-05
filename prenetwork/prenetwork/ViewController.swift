//
//  ViewController.swift
//  prenetwork
//
//  Created by 김민재 on 2023/05/06.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue

    }

    private func signUp() {
        SignUpService.shared.signUp(email: "ffffdff@naver.com", nickname: "intelijjkk", password: "Ddddddf2!") { response in
            
            switch response {
            case .success(let data):
                guard let data = data as? BaseResponseType<SignUpResponse> else { return }
                dump(data)
            default:
                return
            }
        }
    }
}

