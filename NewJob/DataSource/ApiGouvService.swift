//
//  apiGouvService.swift
//  NewJob
//
//  Created by Pierre on 18/02/2022.
//

import Foundation

final class ApiGouvService {
    // MARK: - Properties

    private let session: URLSession
    private let apiConstant = ApiGouvAcess()

    // MARK: - Initializer
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    // MARK: - Methods
    func fetchCityName(cityName: String, callback: @escaping (Result<CityGeoAPIResponseElement, NetworkErrors>) -> Void) {
        guard let baseURL: URL = .init(string: apiConstant.geoApiGouv + "/communes?") else { return }
        let url : URL = encode(with: baseURL, and: [
            ("nom",cityName),
            ("fields", "nom,code,codesPostaux"),
            ("format", "json"),
        ])
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        print(request)
        session.dataTask(with: request) { data, response, error in
        
            guard let data = data else {
                callback(.failure(.noData))
                return
            }
//            print("data : ")
//            print(data)
            guard let dataDecoded = try? JSONDecoder().decode(CityGeoAPIResponseElement.self, from: data) else {
                callback(.failure(.undecodableData))
                return
            }
            callback(.success(dataDecoded))
        }
        .resume()
    }
    
}

extension ApiGouvService: URLEncodable {}
