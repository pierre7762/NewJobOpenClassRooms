//
//  ApiGouvServiceTest.swift
//  NewJobTests
//
//  Created by Pierre on 28/11/2022.
//

import XCTest
@testable import NewJob

final class ApiGouvServiceTest: XCTestCase {

    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionConfiguration
    }()
    
    func testsFetchCity_WhenFakeSessionWithCorrectData_ThenShouldReturnSuccess() {
        URLProtocolFake.fakeURLs = [FakeResponseData.apiGouvServiceUrl: (FakeResponseData.correctDataApiGouvService, FakeResponseData.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: ApiGouvService = .init(session: fakeSession)

        sut.fetchCityCode(cityName: "Arras") { result in
            guard case .success(let success) = result else { return }
            XCTAssertTrue(success[0].code == "62041")
        }
    }

}
