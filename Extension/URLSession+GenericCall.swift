//
//  URLSession+GenericCall.swift
//  NewJob
//
//  Created by Pierre on 12/12/2022.
//

import Foundation

extension URLSession {

    // MARK: - Generic call

    func dataTask<T: Decodable>(with url: URL, callback: @escaping (Result<T, NetworkErrors>) -> Void) {
        dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                callback(.failure(.noData))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(.invalidResponse))
                return
            }
            guard let dataDecoded = try? JSONDecoder().decode(T.self, from: data) else {
                callback(.failure(.undecodableData))
                return
            }
            callback(.success(dataDecoded))
        }.resume()
    }
    
    
}
