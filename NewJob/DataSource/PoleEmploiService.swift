//
//  weatherService.swift
//  LeBaluchon
//
//  Created by Pierre on 02/09/2021.
//

import Foundation
import SwiftUI

protocol PoleEmploiProtocol {
    func getPoleEmploiToken(callback: @escaping (Result<PoleEmploiToken, NetworkErrors>) -> Void)
    func getPoleEmploiJobs(search: Search,activeToken: String,callback: @escaping (Result<PoleEmploiResponse, NetworkErrors>) -> Void)
}

final class PoleEmploiService: PoleEmploiProtocol {
    
    // MARK: - Properties
    
    private let session: URLSession
    private var task: URLSessionDataTask?
    private let apiConstant = ApiAccessInfo()
    private let apiGouv = ApiGouvService()
    var token = "";
    
    // MARK: - Initializer
    init(session: URLSession = URLSession(configuration: .ephemeral)) {
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
            ("scope", "o2dsoffre api_offresdemploiv2 api_explorateurmetiersv1 explojob application_PAR_newjob_6416a72235b39868ab77ea25e02e64d43804df63b8fb491bc0c45aab9fdfe9ea")
        ])
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                callback(.failure(.noData))
                return
            }
            guard let dataDecoded = try? JSONDecoder().decode(PoleEmploiToken.self, from: data) else {
                callback(.failure(.undecodableData))
                return
            }
            callback(.success(dataDecoded))
        }
        .resume()
    }
    
    func createOptionArray(search: Search) -> [(String, Any)] {
        var array: [(String, Any)] = []
        if search.qualification != "x" {
            array.append(("qualification", search.qualification))
        }
        array.append(("motsCles", search.jobTitle))
        if search.experience != "Non précisé" {
            array.append(("experience", search.experience))
        }
        array.append(("commune", search.codeInsee))
        array.append(("distance", search.distance))
        array.append(("origineOffre", 2 ))
        
        return array
    }
    
    func getPoleEmploiJobs(search: Search,activeToken: String,callback: @escaping (Result<PoleEmploiResponse, NetworkErrors>) -> Void) {
        guard let baseURL: URL = .init(string: apiConstant.PoleEmploi.jobsBaseURL) else { return }
        let optionsArray = createOptionArray(search: search)
        
        let url : URL = encode(with: baseURL, and: optionsArray)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer " + activeToken, forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 206 {
                    //                    print("error !!! \(httpResponse.statusCode) : The server is delivering only part of the resource due to a range header sent by the client. The range header is used by tools like wget to enable resuming of interrupted downloads, or split a download into multiple simultaneous streams")
                } else {
                    print("error !!! \(httpResponse.statusCode)")
                }
            }
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
