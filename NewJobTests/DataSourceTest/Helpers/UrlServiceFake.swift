//
//  UrlServiceFake.swift
//  NewJobTests
//
//  Created by Pierre on 25/11/2022.
//

import Foundation

@testable import NewJob
final class UrlServiceFake {

    // MARK: - Properties

    private let baseStringURL: String = "https://www.test.fr/baseUrl"

    // MARK: - Methods
    
    func buildUrlRequest(param: [(String, Any)]) -> String {
        guard let baseURL: URL = .init(string: baseStringURL) else { return ""}
        let url : URL = encode(with: baseURL, and: param)
        let urlString = url.absoluteString
        
        return urlString
    }
}

extension UrlServiceFake: URLEncodable {}

