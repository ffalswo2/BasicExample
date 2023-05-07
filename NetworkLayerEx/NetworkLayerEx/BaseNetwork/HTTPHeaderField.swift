//
//  HTTPHeaderField.swift
//  NetworkLayerEx
//
//  Created by 김민재 on 2023/05/06.
//

import Foundation
import Alamofire

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
}

enum ContentType: String {
    case json = "Application/json"
}
