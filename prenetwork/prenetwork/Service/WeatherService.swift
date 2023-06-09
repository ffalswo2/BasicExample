//
//  WeatherService.swift
//  prenetwork
//
//  Created by 김민재 on 2023/05/06.
//

import Foundation

import Alamofire

final class WeatherService {
    static let shared = WeatherService()

    private init() {}

    func getWeather(cityName: String,
                completion: @escaping (NetworkResult<Any>) -> Void) {

        let url = Config.baseURL + "/user/signup"
        let header: HTTPHeaders = ["Content/Type": "application/json"]

        let dataRequest = AF.request

        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let value = response.value else { return }
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
            case .failure:
                completion(.networkErr)
            }
        }
    }

    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 201: return isValidData(data: data)
        case 400, 409: return isValidData(data: data)
        case 500: return .serverErr
        default: return .networkErr
        }
    }

    private func isValidData(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(BaseResponseType<>.self, from: data) else {
            return .pathErr
        }

        return .success(decodedData as Any)
    }
}
