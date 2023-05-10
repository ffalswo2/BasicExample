//
//  BaseResponse.swift
//  NetworkLayerEx
//
//  Created by 김민재 on 2023/05/10.
//

import Foundation

struct BaseResponseType<T: Decodable>: Decodable {

  let code: Int
  let message: String
  let data: T?
}

