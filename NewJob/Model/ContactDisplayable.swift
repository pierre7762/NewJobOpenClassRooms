//
//  ContactDisplayable.swift
//  NewJob
//
//  Created by Pierre on 02/09/2022.
//

import Foundation

struct ContactDisplayable {
    var idContactDisplayable: UUID
    var contactId: UUID
    var name: String
    var email: String?
    var mailUnwrapped: String {
        guard let mail = email else { return "" }
        return mail
    }
    var phoneNumber: String
    var functionInCompany: String
    var compagny: String
    var candidacy: [Candidacy]
    var relaunch: [Relaunch]
    
    init(contact: Contact, contactId: UUID) {
        idContactDisplayable = UUID()
        self.contactId = contactId
        name = contact.name ?? "Nom de contact"
        email = contact.email ?? ""
        phoneNumber = contact.phoneNumber ?? "06.00.00.00.00"
        functionInCompany = contact.functionInCompany ?? "Fonction"
        compagny = contact.compagny ?? "Nom de l'entreprise"
        candidacy = contact.candidacy?.allObjects as! [Candidacy]
        relaunch = contact.relaunch?.allObjects as! [Relaunch]
        
    }
}
