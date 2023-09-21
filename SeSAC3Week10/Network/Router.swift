//
//  Router.swift
//  SeSAC3Week10
//
//  Created by 서승우 on 2023/09/20.
//

import Alamofire
import Foundation

// Alamofire을 한 번더 패키징한게 Moya 그래서 Moya를 다운 받으면 Alamofire도 다운된다.

// URLRequestConvertible은 Alamofire에서 가지고 있는 프로토콜
enum Router: URLRequestConvertible {
    private static let key = "gpTWLZjU8e51N8XqIVdx4CS0Qmt4uM8oJEgAHIgeVOk"

    case search(query: String)
    case random
    case photo(id: String)  // 연관값, associated value

    private var baseURL: URL {
        return URL(string: "https://api.unsplash.com/")!
    }

    private var path: String {
        switch self {
        case .search(_):
            return "search/photos"
        case .random:
            return "photos/random"
        case .photo(let id):
            return "photos/\(id)"
        }
    }

    private var method: HTTPMethod {
        switch self {
        case .search(_): return .get
        case .random: return .get
        case .photo(_): return .get
        }
    }

    private var headers: HTTPHeaders {
        return [
            "Authorization": "Client-ID \(Router.key)"
        ]
    }

    var parameters: [String: String] {
        switch self {
        case .search(let query):
            return ["query": query]
        default: return ["": ""]
        }
    }

    // 내부에서 다 완성을 해서? 이 메서드로 통신을 한다?
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.headers = headers
        request.method = method

        do {
            request = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(parameters, into: request)
        } catch {

        }

        return request
    }

}
