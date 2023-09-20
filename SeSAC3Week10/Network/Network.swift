//
//  Network.swift
//  SeSAC3Week10
//
//  Created by 서승우 on 2023/09/19.
//

import Alamofire
import Foundation

// 라우터 패턴
//enum Router: URLRequestConvertible {
//
//    func asURLRequest() throws -> URLRequest {
//        <#code#>
//    }
//
//}

class Network {
    private init() {}

    static let shared = Network()

    // 아무 타입이나 들어오면 안되고 Decodable을 채택한 타입만 들어 올 수 있게!!

    func request<T: Decodable>(
        type: T.Type,
        api: UnsplashAPI,
        completion: @escaping (Result<T, SeSACError>) -> ()
    ) {
        AF.request(
            api.endpoint,
            method: api.method,
            parameters: api.parameters,
            encoding: api.encoding,
            headers: api.headers
        )
        .validate()
        .responseDecodable(of: type) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))

            case .failure(_):
                let statusCode = response.response?.statusCode ?? 500
                guard let error = SeSACError(rawValue: statusCode) else {return}
                completion(.failure(error))
            }
        }
    }

}
