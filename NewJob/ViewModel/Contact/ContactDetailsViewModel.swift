//
//  ContactDetailViewModel.swift
//  NewJob
//
//  Created by Pierre on 21/10/2022.
//

import Foundation

class ContactDetailsViewModel: ObservableObject {
    @Published var showingUpdateSheet = false
    @Published var candidacyArray: [Candidacy] = []
    @Published var showingUpdateContactSheet: Bool = false
    @Published var contact: ContactDisplayable?
    @Published var name = ""

    var pm: PersistenceManager!
    
    func deleteContact(id: UUID) {
        pm.removeContact(contactId: id)
    }
    
    func updateContactData(contactId: UUID) {
        if let contactUpdated = try? pm.fetchContactById(contactId: contactId){
            if contact != nil {
                contact?.name = contactUpdated.name!
                contact?.compagny = contactUpdated.compagny!
                contact?.functionInCompany = contactUpdated.functionInCompany!
                contact?.phoneNumber = contactUpdated.phoneNumber!
                contact?.email = contactUpdated.email!
            } else {
                contact = ContactDisplayable(contact: contactUpdated, contactId: contactId)
            }
        }
    }
    
    func fetchCandidaciesWhoAreConnectedAtThisContact(contactID: UUID, pmTest: PersistenceManager) {
        candidacyArray = pmTest.fetchAllCandidaciesOfContact(contactId: contactID)
    }
    
    
    
}
