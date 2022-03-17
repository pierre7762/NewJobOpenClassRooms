//
//  City.swift
//  NewJob
//
//  Created by Pierre on 17/03/2022.
//

import Foundation


struct City: Identifiable {
    var id = UUID()
    var name: String
    var codeInsee: String
    var postCode: String
    var deptCode: String
}

