//
//  SignUpTarget.swift
//  NetworkLayerEx
//
//  Created by 김민재 on 2023/05/06.
//

import Foundation

import Alamofire

enum SignUpTarget {
    case signUp(SignUpRequest)
}

extension SignUpTarget: TargetType {

    var method: HTTPMethod {
        switch self {
        case .signUp(_): return .post
        }
    }

    var path: String {
        switch self {
        case .signUp(_):
            return "/user/signup"
        }
    }

    var parameters: RequestParams {
        switch self {
        case .signUp(let signUpRequest):
            return .body(signUpRequest)
        }
    }

}
