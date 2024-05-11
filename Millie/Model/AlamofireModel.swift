//
//  AlamofireModel.swift
//  Millie
//
//  Created by 김기남 on 2024/05/11.
//

import Foundation
import Alamofire

struct AlamofireModel {
    static func request<T: Decodable>(of type: T.Type = T.self, urlString: String, completion: @escaping (Result<T, AFError>) -> Void) {
        AF.request(urlString, method: .get)
            .responseDecodable(of: type) { response in
                completion(response.result)
            }
    }
}
