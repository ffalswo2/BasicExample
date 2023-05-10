//
//  APIError.swift
//  NetworkLayerEx
//
//  Created by 김민재 on 2023/05/10.
//

import Foundation



enum AuthError: Error, CustomDebugStringConvertible {

    case wrongPassword(message: String)
    case emptyPassword(message: String)
    case duplicatedUser(message: String)

    var debugDescription: String {
        switch self {
        case .wrongPassword(let message),
                .emptyPassword(let message),
                .duplicatedUser(let message):
            return message
        }
    }
}
