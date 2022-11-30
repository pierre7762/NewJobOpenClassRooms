//
//  FakeResponseData.swift
//  NewJobTests
//
//  Created by Pierre on 25/11/2022.
//

import Foundation

class FakeResponseData {
    static let tokenUrl: URL = URL(string: "https://entreprise.pole-emploi.fr/connexion/oauth2/access_token?realm=/partenaire&grant_type=client_credentials&code=oktest&client_id=PAR_newjob_6416a72235b39868ab77ea25e02e64d43804df63b8fb491bc0c45aab9fdfe9ea&client_secret=e19e7aa3b4afe88c741015fbc5041a266d67a713d5b6fbc414ee2c2d8de4cff3&scope=o2dsoffre%20api_offresdemploiv2%20api_explorateurmetiersv1%20explojob%20application_PAR_newjob_6416a72235b39868ab77ea25e02e64d43804df63b8fb491bc0c45aab9fdfe9ea")!
    static let poleEmploiSearchUrl: URL = URL(string:  "https://api.emploi-store.fr/partenaire/offresdemploi/v2/offres/search?")!
    static let apiGouvServiceUrl: URL = URL(string: "https://geo.api.gouv.fr")!

    static let responseOK = HTTPURLResponse(url: URL(string: "http://test.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseOK206 = HTTPURLResponse(url: URL(string: "http://test.com")!, statusCode: 206, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "http://test.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!

    class NetworkError: Error {}
    static let error = NetworkError()

    static var correctDataToken: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "poleEmploiTokenResponse", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var correctDataPoleEmploiSearch: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "poleEmploiResponse", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var correctDataApiGouvService: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "apiGouvServiceResponse", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let incorrectData = "erreur".data(using: .utf8)!
}
