//
//  SignUpService.swift
//  NetworkLayerEx
//
//  Created by 김민재 on 2023/05/06.
//

import Foundation

import Alamofire

final class SignUpService: BaseService {

    static let shared = SignUpService()

    private init() {}

    func signUp<T: Decodable>(request: SignUpRequest,
                              type: T.Type,
                completion: @escaping (NetworkResult<BaseResponseType<T>>?) -> Void) {

        let dataRequest = API.session.request(SignUpTarget.signUp(request))


        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let value = response.value else { return }
                let networkResult = self.judgeStatus(by: statusCode, value, type: T.self)
                completion(networkResult)
            case .failure:
                completion(.networkErr)
            }
        }
    }
}
