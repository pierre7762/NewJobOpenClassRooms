//
//  ApiGouvResponse.swift
//  NewJob
//
//  Created by Pierre on 18/02/2022.
//

import Foundation

// MARK: - CityGeoAPIResponseElement
struct CityGeoAPIResponseElement: Decodable {
    let nom, code: String
    let codeDepartement: String

    enum CodingKeys: String, CodingKey {
        case nom, code, codeDepartement
    }
}

typealias CityGeoAPIResponse = [CityGeoAPIResponseElement]

