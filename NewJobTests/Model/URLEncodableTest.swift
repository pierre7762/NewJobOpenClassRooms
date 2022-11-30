//
//  URLEncodableTest.swift
//  NewJobTests
//
//  Created by Pierre on 25/11/2022.
//

import XCTest
@testable import NewJob

class URLEncodableTest: XCTestCase {
    let urlService = UrlServiceFake()
    
    func testGivenBaseUrlIsAlone_WhenUseUrlEncodable_ThenReturnBaseUrlAlone() {
        let responseExpected = "https://www.test.fr/baseUrl"
        let response = urlService.buildUrlRequest(param: [])
        
        XCTAssertEqual(responseExpected, response)
    }
    
    func testGivenBaseUrlAndParamAreGiven_WhenUseUrlEncodable_ThenReturnBaseUrlWithParams() {
        let responseExpected = "https://www.test.fr/baseUrl?param1=azerty&param2=querty"
        let response = urlService.buildUrlRequest(param: [("param1", "azerty"), ("param2", "querty")])
        
        XCTAssertEqual(responseExpected, response)
    }
    
}
