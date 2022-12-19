//
//  PoleEmploiServiceTest.swift
//  NewJobTests
//
//  Created by Pierre on 25/11/2022.
//

import XCTest
@testable import NewJob

final class PoleEmploiServiceTest: XCTestCase {
    let urlToken = URL(string: "https://entreprise.pole-emploi.fr/connexion/oauth2/access_token?realm=/partenaire&grant_type=client_credentials&code=oktest&client_id=PAR_newjob_6416a72235b39868ab77ea25e02e64d43804df63b8fb491bc0c45aab9fdfe9ea&client_secret=e19e7aa3b4afe88c741015fbc5041a266d67a713d5b6fbc414ee2c2d8de4cff3&scope=o2dsoffre%20api_offresdemploiv2%20api_explorateurmetiersv1%20explojob%20application_PAR_newjob_6416a72235b39868ab77ea25e02e64d43804df63b8fb491bc0c45aab9fdfe9ea")
    let urlPoleEmploi = URL(string: "https://api.emploi-store.fr/partenaire/offresdemploi/v2/offres/search?qualification=0&motsCles=Livreur&experience=2&commune=62041&distance=50&origineOffre=2")
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionConfiguration
    }()

    func testsFetchToken_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnErrorNoData() {
        URLProtocolFake.fakeURLs = [FakeResponseData.tokenUrl: (nil, nil, FakeResponseData.error)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: PoleEmploiService = .init(session: fakeSession)
        
        sut.getPoleEmploiToken { result in
            guard case .failure(let error) = result else { return }
            XCTAssertTrue(error == .noData)
            XCTAssertTrue(error.description == "The answer does not contain any data")
        }
    }
    
    func testsFetchToken_WhenFakeSessionWithIncorrectData_ThenShouldReturnAnErrorUndecodableData() {
        URLProtocolFake.fakeURLs = [FakeResponseData.tokenUrl: (FakeResponseData.incorrectData, FakeResponseData.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: PoleEmploiService = .init(session: fakeSession)
        
        sut.getPoleEmploiToken { result in
            guard case .failure(let error) = result else { return }
            print(error)
            XCTAssertTrue(error == .undecodableData)
        }
    }
    
    func testsFetchToken_WhenFakeSessionWithCorrectData_ThenShouldReturnSuccess() {
        URLProtocolFake.fakeURLs = [FakeResponseData.tokenUrl: (FakeResponseData.correctDataToken, FakeResponseData.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: PoleEmploiService = .init(session: fakeSession)

        sut.getPoleEmploiToken { result in
            guard case .success(let success) = result else { return }
            XCTAssertTrue(success.accessToken == "7rzjjXw5KHqlwtqzKZht2tdS0yg")
        }
    }

    func testsCreateOptionArray_WhenGiveSearchObject_ThenShouldReturnDictonnary() {
        var searchObject = Search()
        searchObject.jobTitle = "Livreur"
        searchObject.codeInsee = "62041"
        searchObject.qualification = "0"
        searchObject.experience = "2"
        let service = PoleEmploiService()
        
        let expectation: [(String, Any)] = [("qualification", "0"), ("motsCles", "Livreur"), ("experience", "2"), ("commune", "62041"), ("distance", 50), ("origineOffre", 2)]
        
        let test = service.createOptionArray(search: searchObject)
        
        XCTAssertEqual(test.count, expectation.count)
    }
    
    func testsGetPoleEmploiJobs_WhenFakeSessionWithCorrectData_ThenShouldReturnSuccess() {
        URLProtocolFake.fakeURLs = [urlPoleEmploi: (FakeResponseData.correctDataPoleEmploiSearch, FakeResponseData.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: PoleEmploiService = .init(session: fakeSession)
        var searchObject = Search()
        searchObject.jobTitle = "Livreur"
        searchObject.codeInsee = "62041"
        searchObject.qualification = "0"
        searchObject.experience = "2"
        
        sut.getPoleEmploiJobs(search: searchObject, activeToken: "DVGtqtvaz") { result in
            guard case .success(let success) = result else { return }
            XCTAssertEqual(success.resultats.count, 2 )
        }
    }
    
    func testsGetPoleEmploiJobs_WhenFakeSessionWithCorrectData_ThenShouldReturnSuccess206() {
        URLProtocolFake.fakeURLs = [urlPoleEmploi: (FakeResponseData.correctDataPoleEmploiSearch, FakeResponseData.responseOK206, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: PoleEmploiService = .init(session: fakeSession)
        var searchObject = Search()
        searchObject.jobTitle = "Livreur"
        searchObject.codeInsee = "62041"
        searchObject.qualification = "0"
        searchObject.experience = "2"
        
        sut.getPoleEmploiJobs(search: searchObject, activeToken: "DVGtqtvaz") { result in
            guard case .success(let success) = result else { return }
            XCTAssertEqual(success.resultats.count, 2 )
        }
    }
    
    func testsGetPoleEmploiJobs_WhenFakeSessionWithIncorrectData_ThenShouldReturnUndecodable() {
        URLProtocolFake.fakeURLs = [urlPoleEmploi: (nil, FakeResponseData.responseKO, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: PoleEmploiService = .init(session: fakeSession)
        var searchObject = Search()
        searchObject.jobTitle = "Livreur"
        searchObject.codeInsee = "62041"
        searchObject.qualification = "0"
        searchObject.experience = "2"
        
        sut.getPoleEmploiJobs(search: searchObject, activeToken: "DVGtqtvaz") { result in
            guard case .failure(let error) = result else { return }
            XCTAssertEqual(error, .undecodableData)
        }
    }
    
    func testsGetPoleEmploiJobs_WhenFakeSessionWithIncorrectData_ThenShouldReturnNoData() {
        URLProtocolFake.fakeURLs = [urlPoleEmploi: (nil, FakeResponseData.responseKO, FakeResponseData.error)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: PoleEmploiService = .init(session: fakeSession)
        var searchObject = Search()
        searchObject.jobTitle = "Livreur"
        searchObject.codeInsee = "62041"
        searchObject.qualification = "0"
        searchObject.experience = "2"
        
        sut.getPoleEmploiJobs(search: searchObject, activeToken: "DVGtqtvaz") { result in
            guard case .failure(let error) = result else { return }
            XCTAssertEqual(error, .noData)
        }
    }
    
   

}
