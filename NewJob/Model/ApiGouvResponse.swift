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
    let codesPostaux: [String]
    let codeDepartement, codeRegion: String
    let population, score: Int

    enum CodingKeys: String, CodingKey {
        case nom, code, codesPostaux, codeDepartement, codeRegion, population
        case score = "_score"
    }
}

typealias CityGeoAPIResponse = [CityGeoAPIResponseElement]
