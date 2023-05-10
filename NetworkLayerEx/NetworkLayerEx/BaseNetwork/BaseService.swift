//
//  BaseService.swift
//  NetworkLayerEx
//
//  Created by 김민재 on 2023/05/06.
//

import Foundation

import Alamofire

class BaseService {

    func judgeStatus<T: Decodable>(by statusCode: Int, _ data: Data, type: T.Type) -> NetworkResult<BaseResponseType<T>> {
        switch statusCode {
        case 201: return isValidData(data: data, type: T.self)
        case 400, 409: return isValidData(data: data, type: T.self)
        case 500: return .serverErr
        default: return .networkErr
        }
    }

    private func isValidData<T: Decodable>(data: Data, type: T.Type) -> NetworkResult<BaseResponseType<T>> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(BaseResponseType<T>.self, from: data) else {
            print("json decoded failed !")
            return .pathErr
        }

        return .success(decodedData)
    }
}
