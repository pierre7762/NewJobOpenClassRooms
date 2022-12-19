//
//  ApiGouvFakeService.swift
//  NewJobTests
//
//  Created by Pierre on 11/12/2022.
//

import Foundation
@testable import NewJob

struct ApiGouvFakeService: ApiGouvProtocol {
    let tokenResult: Result<NewJob.CityGeoAPIResponse, NewJob.NetworkErrors>
    
    init(tokenResult: Result<NewJob.CityGeoAPIResponse, NewJob.NetworkErrors>) {
        self.tokenResult = tokenResult
    }
    
    
    func fetchCityCode(cityName: String, callback: @escaping (Result<NewJob.CityGeoAPIResponse, NewJob.NetworkErrors>) -> Void) {
        callback(tokenResult)
    }
}
