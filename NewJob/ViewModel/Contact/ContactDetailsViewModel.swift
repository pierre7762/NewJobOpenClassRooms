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

//    var pm = PersistenceManager(coreDataStack: CoreDataStack(modelName: "NewJob"))
//    var pm = PersistenceManager(coreDataStack: nil)
    var pm = PersistenceManager()
    
    func deleteContact(id: UUID) {
        pm.removeContact(contactId: id)
    }
    
    func fetchCandidaciesWhoAreConnectedAtThisContact(contactID: UUID) {
        candidacyArray = pm.fetchAllCandidaciesOfContact(contactId: contactID)
    }
    
    
    
}
