//
//  SignUpResponse.swift
//  NetworkLayerEx
//
//  Created by 김민재 on 2023/05/06.
//

import Foundation


struct SignUpResponse: Decodable {
    let code: Int
    let message: String
    let data: UserInfo?
}

struct UserInfo: Decodable {
    let userId: Int
    let nickname: String
}


extension SignUpResponse {
    var toDomain: SignUp {
        return SignUp(nickname: data?.nickname ?? "")
    }
}
