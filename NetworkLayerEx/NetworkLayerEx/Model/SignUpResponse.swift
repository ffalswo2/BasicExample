//
//  SignUpResponse.swift
//  NetworkLayerEx
//
//  Created by 김민재 on 2023/05/06.
//

import Foundation


struct SignUpResponseDTO: Decodable {
    let userId: Int
    let nickname: String
}


extension SignUpResponseDTO {
    var toDomain: SignUp {
        return SignUp(nickname: nickname)
    }
}
