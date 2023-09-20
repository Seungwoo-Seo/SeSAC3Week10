//
//  NetworkBasic.swift
//  SeSAC3Week10
//
//  Created by 서승우 on 2023/09/19.
//

import Alamofire
import Foundation

// LocalizedError - 하나의 국가에만 대응하는게 아닐 때
enum SeSACError: Int, Error, LocalizedError {
    case unauthorized = 401
    case permissionDenied = 403
    case invalidServer = 500
    case missingParameter = 400

    var description: String {
        switch self {
        case .unauthorized: return "인증 정보가 없습니다"
        case .permissionDenied: return "권한이 없습니다"
        case .invalidServer: return "서버 점검 중입니다"
        case .missingParameter: return "검색어를 입력해주세요"
        }
    }
}

final class NetworkBasic {
    private init() {}

    static let shared = NetworkBasic()

    // completion: @escaping (Photo?, Error?) -> ()
    // 우리는 안다. Photo 혹은 Error 중 하나가 존재하면 다른 하나는 nil이라는 것을
    // 근데 "문법적으로는" 둘 다 nil, nil 혹은 Photo(), Error()가 가능하기 때문에
    // 이런 경우를 굳이 가능케 할 필요가 없다.

    // 그래서 사용할게 -> Result Type -> ex) Result<Photo, Error>
    // Result 타입은 .success 혹으 .failure 두 가지의 경우의 수 밖에 없기 때문에
    // 문법적으로도 두 가지의 경우의 수만 존재하게 할 수 있다
    func request(api: UnsplashAPI, query: String, completion: @escaping (Result<Photo, SeSACError>) -> ()) {   // search photo
        // get 방식으로 request를 보낼 때 paramters 파라미터를 사용할 때 주의점-------!
        // paramters 파라미터를 사용하면 Alamofire 내부적으로 post 방식으로 사용됌
        // 그래서 encoding 파라미터에 default로 .httpBody가 설정되고
        // 그래서 get 방식의 api에 request를 보내면 에러가 발생한다.
        // get 방식의 request를 보내면서 parameters 파라미터를 사용할려면
        // encoding 파라미터에 URLEncoding(destination: .queryString)
        // 이라고 인코딩 방식을 쿼리스트링으로 사용할 수 있게 명시해 줘야 한다.
        AF
            .request(
                api.endpoint,
                method: api.method,
                parameters: api.parameters,
                encoding: api.encoding,
                headers: api.headers
            )
            .validate()
            .responseDecodable(of: Photo.self) { response in
                switch response.result {
                case .success(let photo):
                    dump(photo)
                    completion(.success(photo))

                case .failure(_):
                    // response가 잘못되어서 의도보다 빠르게 종료될 수 있다.
                    // guard let statusCode = response.response?.statusCode else {return}
                    // guard문으로 처리하지 말고 nil 병합 연산자로 옵셔널을 처리해서
                    // response의 이상이 있을 때를 대비해서 default 값을 할당해 주는 것도 좋은 것 같다
                    let statusCode = response.response?.statusCode ?? 500
                    guard let error = SeSACError(rawValue: statusCode) else {return}
                    completion(.failure(error))
                }
            }
    }

    func random(api: UnsplashAPI, completion: @escaping (Result<PhotoResult, SeSACError>) -> ()) {
        AF
            .request(api.endpoint, method: api.method, headers: api.headers)
            .validate()
            .responseDecodable(of: PhotoResult.self) { response in
                switch response.result {
                case .success(let photoResult):
                    print("random -----------------------")
                    completion(.success(photoResult))

                case .failure(_):
                    let statusCode = response.response?.statusCode ?? 500
                    guard let error = SeSACError(rawValue: statusCode) else {return}
                    completion(.failure(error))
                }
            }
    }

    func detailPhoto(api: UnsplashAPI, id: String, completion: @escaping (Result<PhotoResult, SeSACError>) -> ()) {
        AF
            .request(api.endpoint, method: api.method, headers: api.headers)
            .validate()
            .responseDecodable(of: PhotoResult.self) { response in
                switch response.result {
                case .success(let photo):
                    print("detail -----------------------")
                    dump(photo)
                    completion(.success(photo))

                case .failure(_):
                    let statusCode = response.response?.statusCode ?? 500
                    guard let error = SeSACError(rawValue: statusCode) else {return}
                    completion(.failure(error))
                }
            }
    }

}
