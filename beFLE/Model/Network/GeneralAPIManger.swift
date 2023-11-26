//
//  GeneralAPIManger.swift
//  beFLE
//
//  Created by 송재훈 on 11/9/23.
//

import SwiftUI
import Moya

class GeneralAPIManger {
    /// Generic API 요청 함수
    /// - Parameters:
    ///     - for target: target API
    ///     - type: 디코딩 할 구조체 타입
    ///     - compeletion: 디코딩 된 데이터 또는 에러를 반환
    static func request<T: Codable>(for target: GeneralAPI, type: T.Type?, completion: @escaping ((Result<T?, MoyaError>) -> ())) {
        let provider = MoyaProvider<GeneralAPI>()
        
        provider.request(target) { result in
            switch result {
            case .success(let resp):
                if (200..<300).contains(resp.statusCode) {
                    if let type = type {
                        if let decodedData = try? JSONDecoder().decode(type, from: resp.data) {
                            completion(.success(decodedData))
                        }
                        else {
                            completion(.success(nil))
                        }
                    }
                    else {
                        completion(.failure(.statusCode(resp)))
                    }
                }
                else {
#if DEBUG
                    if 403 == resp.statusCode {
                        print("Authentication failed")
                    }
#endif
                    completion(.failure(.statusCode(resp)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func request(for target: GeneralAPI, completion: @escaping ((Result<Int, MoyaError>) -> ())) {
        let provider = MoyaProvider<GeneralAPI>()
        
        provider.request(target) { result in
            switch result {
            case .success(let resp):
                if (200..<300).contains(resp.statusCode) {
                    completion(.success(resp.statusCode))
                }
                else {
#if DEBUG
                    if 403 == resp.statusCode {
                        print("Authentication failed")
                    }
#endif
                    completion(.failure(.statusCode(resp)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
