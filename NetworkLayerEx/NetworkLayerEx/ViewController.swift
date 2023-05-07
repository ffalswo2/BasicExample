//
//  ViewController.swift
//  NetworkLayerEx
//
//  Created by 김민재 on 2023/05/06.
//

import UIKit

import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        signUp()
    }


    private func signUp() {
        let request = SignUpRequest(email: "fsdfsd@naver.com", nickname: "inJtelK", password: "1234!")
        
        SignUpService.shared.signUp(request: request) { response in
            switch response {
            case .success(let data):
                guard let data = data as? SignUpResponse else {
                    print("decode failed")
                    return
                }
                dump(data)
            default:
                return
            }
        }
    }

}

