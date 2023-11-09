//
//  GeneralAPIManger.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/9/23.
//

import SwiftUI
import Moya

class GeneralAPIManger {
    static func request<T: Codable>(for target: GeneralAPI, type: T.Type, completion: @escaping ((Result<T, MoyaError>) -> ())) {
        let provider = MoyaProvider<GeneralAPI>()
        
        provider.request(target) { result in
            switch result {
            case .success(let resp):
                if (200..<300).contains(resp.statusCode) {
                    if let decodedData = try? JSONDecoder().decode(type, from: resp.data) {
                        completion(.success(decodedData))
                    }
                    else {
                        completion(.failure(.requestMapping("decode error")))
                    }
                }
                else {
                    completion(.failure(.statusCode(resp)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
