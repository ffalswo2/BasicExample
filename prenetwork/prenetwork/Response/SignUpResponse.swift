//
//  SignUpResponse.swift
//  prenetwork
//
//  Created by 김민재 on 2023/05/06.
//

import Foundation

struct SignUpResponse: Decodable {
    let userId: Int
    let nickname: String
}
