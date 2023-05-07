//
//  SignUpService.swift
//  NetworkLayerEx
//
//  Created by 김민재 on 2023/05/06.
//

import Foundation

import Alamofire

final class SignUpService {

    static let shared = SignUpService()

    private init() {}

    func signUp(request: SignUpRequest, completion: @escaping (NetworkResult<Any>) -> Void) {

        let dataRequest = AF.request(SignUpTarget.signUp(request))

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
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(SignUpResponse.self, from: data) else { return .pathErr }

        switch statusCode {
        case 201: return .success(decodedData as Any)
        case 400, 409: return .success(decodedData as Any)
        case 500: return .serverErr
        default: return .networkErr
        }
    }
}
