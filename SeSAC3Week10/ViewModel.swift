//
//  ViewModel.swift
//  SeSAC3Week10
//
//  Created by 서승우 on 2023/09/20.
//

import Foundation

final class ViewModel {

    func request(completion: @escaping (URL) -> ()) {
        Network.shared.requestConvertible(type: PhotoResult.self, api: .random) { result in
            switch result {
            case .success(let photoResult):
                let url = URL(string: photoResult.urls.thumb)!
                completion(url)

            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }

}
