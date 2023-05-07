//
//  SignUpRequest.swift
//  NetworkLayerEx
//
//  Created by 김민재 on 2023/05/06.
//

import Foundation


struct SignUpRequest: Encodable {
    let email: String
    let nickname: String
    let password: String
}
