//
//  weatherService.swift
//  LeBaluchon
//
//  Created by Pierre on 02/09/2021.
//

import Foundation
import SwiftUI

final class PoleEmploiService {

    // MARK: - Properties

    private let session: URLSession
    private let apiConstant = ApiAccessInfo()
    private let apiGouv = ApiGouvService()
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
//            print("data : ")
//            print(data)
            guard let dataDecoded = try? JSONDecoder().decode(PoleEmploiToken.self, from: data) else {
                callback(.failure(.undecodableData))
                return
            }
            callback(.success(dataDecoded))
        }
        .resume()
    }
    
    func getPoleEmploiJobs(search: Search,activeToken: String,callback: @escaping (Result<PoleEmploiResponse, NetworkErrors>) -> Void) {
        guard let baseURL: URL = .init(string: apiConstant.PoleEmploi.jobsBaseURL) else { return }
        let url : URL = encode(with: baseURL, and: [
            ("qualification", ""),
            ("motsCles", search.jobTitle),
            ("commune", search.cityCode),
            ("origineOffre", 2 ),
        ])
        print(url)
        var request = URLRequest(url: url)
        print("token : \(activeToken)")
        request.httpMethod = "GET"
        request.addValue("Bearer " + activeToken, forHTTPHeaderField: "Authorization")
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                callback(.failure(.noData))
                return
            }
            guard let dataDecoded = try? JSONDecoder().decode(PoleEmploiResponse.self, from: data) else {
//                print(data)
                callback(.failure(.undecodableData))
                return
            }
            callback(.success(dataDecoded))
        }
        .resume()
    }
    
    private func convertArrayStringToString(array: [String]) -> String {
        var text = ""
        
        for (index, item) in array.enumerated() {
            text += item
            if index < array.count - 1 {
                text += ","
            }
        }
        print("all job search : ", text)
        
        return text
    }
    
}

extension PoleEmploiService: URLEncodable {}
