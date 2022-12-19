//
//  ApiGouvServiceTest.swift
//  NewJobTests
//
//  Created by Pierre on 28/11/2022.
//

import XCTest
@testable import NewJob

final class ApiGouvServiceTest: XCTestCase {
    let urlGouvService = URL(string:"https://geo.api.gouv.fr/communes?nom=Arras&fields=nom,code,codeDepartement&format=json")
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionConfiguration
    }()
    
    func testsFetchCity_WhenFakeSessionWithCorrectData_ThenShouldReturnSuccess() {
        URLProtocolFake.fakeURLs = [urlGouvService: (FakeResponseData.correctDataApiGouvService, FakeResponseData.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: ApiGouvService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "success")
        sut.fetchCityCode(cityName: "Arras", callback: { result in
            guard case .success(let success) = result else { return }
            XCTAssertTrue(success[0].code == "62041")
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testsFetchCity_WhenFakeSessionWithIncorrectData_ThenShouldReturnUndecodableData() {
        URLProtocolFake.fakeURLs = [urlGouvService: (FakeResponseData.incorrectData, FakeResponseData.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: ApiGouvService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "incorrect")
        sut.fetchCityCode(cityName: "Arras", callback: { result in
            guard case .failure(let error) = result else { return }
            XCTAssertTrue(error == .undecodableData)
            XCTAssertTrue(error.description == "Decoding problem")
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testsFetchCity_WhenFakeSessionWithIncorrectData_ThenShouldReturnNoData() {
        URLProtocolFake.fakeURLs = [urlGouvService: (nil, FakeResponseData.responseKO, FakeResponseData.error)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: ApiGouvService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "no data")
        sut.fetchCityCode(cityName: "Arras", callback: { result in
            guard case .failure(let error) = result else { return }
            XCTAssertTrue(error == .noData)
            XCTAssertTrue(error.description == "The answer does not contain any data")
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testsFetchCity_WhenFakeSessionWithError_ThenShouldReturnInvalidResponse() {
        URLProtocolFake.fakeURLs = [urlGouvService: (nil, nil, FakeResponseData.error)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: ApiGouvService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "invalid response")
        sut.fetchCityCode(cityName: "@", callback: { result in
            guard case .failure(let error) = result else { return }
            XCTAssertTrue(error == .invalidResponse)
            XCTAssertTrue(error.description == "The answer is invalide")
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
}
