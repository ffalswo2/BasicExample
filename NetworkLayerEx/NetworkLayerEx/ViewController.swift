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
        let request = SignUpRequest(email: "kkkkkkk@naver.com", nickname: "inJtelK", password: "RM31rrrrrrr!")

        SignUpService.shared.signUp(request: request, type: SignUpResponseDTO.self) { response in
            switch response {
            case .success(let data):
//                dump(data)
                guard let data = data as? SignUpResponseDTO else {
                    print("no data")
                    return
                }

//                dump(data)
            default:
                return
            }
        }
    }

}

