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
    func fetchCityCode(cityName: String, callback: @escaping (Result<CityGeoAPIResponse, NetworkErrors>) -> Void) {
        guard let baseURL: URL = .init(string: apiConstant.geoApiGouv + "/communes?") else { return }
        let url : URL = encode(with: baseURL, and: [
            ("nom",cityName),
            ("fields", "nom,code,codeDepartement"),
            ("format", "json"),
        ])
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
//        print(request)
        session.dataTask(with: request) { data, response, error in
        
            guard let data = data else {
                callback(.failure(.noData))
                return
            }
//            print("data : ")
//            print(data)
            guard let dataDecoded = try? JSONDecoder().decode(CityGeoAPIResponse.self, from: data) else {
                callback(.failure(.undecodableData))
                return
            }
            callback(.success(dataDecoded))
        }
        .resume()
    }
    
}

extension ApiGouvService: URLEncodable {}
