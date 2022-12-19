//
//  apiGouvService.swift
//  NewJob
//
//  Created by Pierre on 18/02/2022.
//

import Foundation

protocol ApiGouvProtocol {
    func fetchCityCode(cityName: String, callback: @escaping (Result<CityGeoAPIResponse, NetworkErrors>) -> Void)
}

final class ApiGouvService: ApiGouvProtocol {
    // MARK: - Properties
    
    var session: URLSession
    private var task: URLSessionDataTask?
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
        NetworkLogger(url: url).show()
        #if DEBUG
        task?.cancel()
        #endif
        session.dataTask(with: url, callback: callback)
    }
    
}

extension ApiGouvService: URLEncodable {}
