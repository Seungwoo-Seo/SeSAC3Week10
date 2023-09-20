//
//  UnsplashAPI.swift
//  SeSAC3Week10
//
//  Created by 서승우 on 2023/09/19.
//

// Alamofire을 좀 더 추상화한게 Moya
// Alamofire에서 Moya처럼 할 수 있게 해주는게
// URLRequestConventible 이라는 프로토콜이 있다.
import Alamofire
import Foundation

enum UnsplashAPI {
    private static let key = "gpTWLZjU8e51N8XqIVdx4CS0Qmt4uM8oJEgAHIgeVOk"

    case search(query: String)
    case random
    case photo(id: String)  // 연관값, associated value

    private var baseURL: String {
        return "https://api.unsplash.com/"
    }

    var endpoint: URL {
        switch self {
        case .search(_):
            return URL(string: baseURL + "search/photos")!
        case .random:
            return URL(string: baseURL + "photos/random")!
        case .photo(let id):
            return URL(string: baseURL + "photos/\(id)")!
        }
    }

    var method: HTTPMethod {
        switch self {
        case .search(_): return .get
        case .random: return .get
        case .photo(_): return .get
        }
    }

    var parameters: Parameters? {
        switch self {
        case .search(let query):
            return ["query": query]
        default: return nil
        }
    }

    var encoding: URLEncoding {
        switch self {
        case .search(_):
            return URLEncoding(destination: .queryString)
        default:
            return URLEncoding.default
        }
    }

    var headers: HTTPHeaders {
        return [
            "Authorization": "Client-ID \(UnsplashAPI.key)"
        ]
    }

}
