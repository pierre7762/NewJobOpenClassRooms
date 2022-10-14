//
//  ContactDisplayable.swift
//  NewJob
//
//  Created by Pierre on 02/09/2022.
//

import Foundation

struct ContactDisplayable {
    var name: String
    var email: String
    var phoneNumber: String
    var functionInCompany: String
    var compagny: String
    var candidacy: [Candidacy]
    var relaunch: [Relaunch]
    
    init(contact: Contact) {
        name = contact.name ?? "Nom de contact"
        email = contact.email ?? "Email"
        phoneNumber = contact.phoneNumber ?? "06.00.00.00.00"
        functionInCompany = contact.functionInCompany ?? "Fonction"
        compagny = contact.compagny ?? "Nom de l'entreprise"
        candidacy = []
        relaunch = []
        
    }
}
