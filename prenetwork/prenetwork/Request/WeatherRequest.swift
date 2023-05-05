//
//  WeatherRequest.swift
//  prenetwork
//
//  Created by 김민재 on 2023/05/06.
//

import Foundation

struct WeatherRequest: Encodable {
    var q: String
    var appId: String
}
