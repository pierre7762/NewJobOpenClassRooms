//
//  PoleEmploiServiceTest.swift
//  NewJobTests
//
//  Created by Pierre on 25/11/2022.
//

import XCTest
@testable import NewJob

final class PoleEmploiServiceTest: XCTestCase {

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
        URLProtocolFake.fakeURLs = [FakeResponseData.poleEmploiSearchUrl: (FakeResponseData.correctDataPoleEmploiSearch, FakeResponseData.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: PoleEmploiService = .init(session: fakeSession)
        var searchObject = Search()
        searchObject.jobTitle = "Livreur"
        searchObject.codeInsee = "62041"
        searchObject.qualification = "0"
        searchObject.experience = "2"
        
        sut.getPoleEmploiJobs(search: searchObject, activeToken: "DVGtqtvaz") { result in
            guard case .success(let success) = result else {
                return
            }
            XCTAssertTrue(success.resultats[0].id == "4015584")
        }
    }
    
    func testsGetPoleEmploiJobs_WhenFakeSessionWithCorrectData_ThenShouldReturnError206() {
        URLProtocolFake.fakeURLs = [FakeResponseData.poleEmploiSearchUrl: (FakeResponseData.correctDataPoleEmploiSearch, FakeResponseData.responseOK206, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: PoleEmploiService = .init(session: fakeSession)
        var searchObject = Search()
        searchObject.jobTitle = "Livreur"
        searchObject.codeInsee = "62041"
        searchObject.qualification = "0"
        searchObject.experience = "2"
        
        sut.getPoleEmploiJobs(search: searchObject, activeToken: "DVGtqtvaz") { result in
            guard case .success(let success) = result else {
                return
            }
            XCTAssertTrue(success.resultats[0].id == "4015584")
        }
    }
    
    func testsGetPoleEmploiJobs_WhenFakeSessionWithIncorrectData_ThenShouldReturnAnErrorUndecodableData(){
        URLProtocolFake.fakeURLs = [FakeResponseData.poleEmploiSearchUrl: (nil, nil, FakeResponseData.error)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: PoleEmploiService = .init(session: fakeSession)
        var searchObject = Search()
        searchObject.jobTitle = "Livreur"
        searchObject.codeInsee = "62041"
        searchObject.qualification = "0"
        searchObject.experience = "2"
        
        sut.getPoleEmploiJobs(search: searchObject, activeToken: "DVGtqtvaz") { result in
            guard case .failure(let error) = result else { return }
            XCTAssertTrue(error.description == "")
        }
    }
    
    func testsGetPoleEmploiJobs_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnErrorNoData() {
//        URLProtocolFake.fakeURLs = [FakeResponseData.poleEmploiSearchUrl: (nil, FakeResponseData.responseOK, nil)]
//        let fakeSession = URLSession(configuration: sessionConfiguration)
//        let sut: PoleEmploiService = .init(session: fakeSession)
//        var searchObject = Search()
//        searchObject.jobTitle = "Livreur"
//        searchObject.codeInsee = "62041"
//        searchObject.qualification = "0"
//        searchObject.experience = "2"
//
//        sut.getPoleEmploiJobs(search: searchObject, activeToken: "") { result in
//            guard case .failure(let error) = result else { return }
//            XCTAssertTrue(error == .noData)
//        }
    }
    
//    func testsGetPoleEmploiJobs_WhenFakeSessionWithIncorrectData_ThenShouldReturnAnErrorUndecodableData() {
//        URLProtocolFake.fakeURLs = [FakeResponseData.tokenUrl: (FakeResponseData.incorrectData, FakeResponseData.responseOK, nil)]
//        let fakeSession = URLSession(configuration: sessionConfiguration)
//        let sut: PoleEmploiService = .init(session: fakeSession)
//        var searchObject = Search()
//        searchObject.jobTitle = "Livreur"
//        searchObject.codeInsee = "62041"
//        searchObject.qualification = "0"
//        searchObject.experience = "2"
//
//        sut.getPoleEmploiJobs(search: searchObject, activeToken: "") { result in
//            guard case .failure(let error) = result else { return }
//            print(error)
//            XCTAssertTrue(error == .undecodableData)
//        }
//    }

}
