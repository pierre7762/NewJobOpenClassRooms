//
//  weatherService.swift
//  LeBaluchon
//
//  Created by Pierre on 02/09/2021.
//

import Foundation

final class PoleEmploiService {

    // MARK: - Properties

    private let session: URLSession
//    private let tokenBaseURL: String = "https://entreprise.pole-emploi.fr/connexion/oauth2/access_token?"
//    private let jobsBaseURL: String = "https://api.emploi-store.fr/partenaire/offresdemploi/v2/offres/search?"
    private let apiConstant = ApiAccessInfo()
    var token = "";

    // MARK: - Initializer

    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    // MARK: - Methods
    
    func getPoleEmploiToken(callback: @escaping (Result<PoleEmploiToken, NetworkErrors>) -> Void) {
        guard let baseURL: URL = .init(string: apiConstant.PoleEmploi.tokenBaseURL) else { return }
        let url : URL = encode(with: baseURL, and: [
            ("realm","/partenaire"),
            ("grant_type", "client_credentials"),
            ("code", "oktest"),
            ("client_id", apiConstant.PoleEmploi.client_id ),
            ("client_secret", apiConstant.PoleEmploi.client_secret),
            ("scope", "o2dsoffre api_offresdemploiv2 application_PAR_newjob_6416a72235b39868ab77ea25e02e64d43804df63b8fb491bc0c45aab9fdfe9ea")
        ])
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        print(request)
        session.dataTask(with: request) { data, response, error in
        
            guard let data = data else {
                callback(.failure(.noData))
                return
            }
            print("data : ")
            print(data)
            guard let dataDecoded = try? JSONDecoder().decode(PoleEmploiToken.self, from: data) else {
                callback(.failure(.undecodableData))
                return
            }
            callback(.success(dataDecoded))
        }
        .resume()
    }
    
    func getPoleEmploiJobs(activeToken: String,callback: @escaping (Result<PoleEmploiResponse, NetworkErrors>) -> Void) {
        guard let baseURL: URL = .init(string: apiConstant.PoleEmploi.jobsBaseURL) else { return }
        let url : URL = encode(with: baseURL, and: [
            ("qualification", 0),
            ("motsCles", "informatique"),
            ("commune", "51069,76322,46083,12172,28117"),
            ("origineOffre", 2 ),
        ])
        
        var request = URLRequest(url: url)
        print("token : \(activeToken)")
        request.httpMethod = "GET"
        request.addValue("Bearer " + activeToken, forHTTPHeaderField: "Authorization")
        session.dataTask(with: request) { data, response, error in
//        print(response)
            guard let data = data else {
                callback(.failure(.noData))
                return
            }
            guard let dataDecoded = try? JSONDecoder().decode(PoleEmploiResponse.self, from: data) else {
                callback(.failure(.undecodableData))
                return
            }
            callback(.success(dataDecoded))
        }
        .resume()
    }

    

}

extension PoleEmploiService: URLEncodable {}
