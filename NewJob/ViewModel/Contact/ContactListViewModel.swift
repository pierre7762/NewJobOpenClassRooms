//
//  ContactListViewModel.swift
//  NewJob
//
//  Created by Pierre on 28/10/2022.
//

import Foundation

class ContactListViewModel: ObservableObject {
    @Published var contacts: [Contact] = []
    @Published var showingDestinataireSheet = false
//    var pm = PersistenceManager(coreDataStack: CoreDataStack(modelName: "NewJob"))
//    var pm = PersistenceManager()
    var pm: PersistenceManager!
    
    func getContactsList() {
        contacts = pm.fetchContact()
    }
    
    func deleteContact(id: UUID) {
        pm.removeContact(contactId: id)
        getContactsList()
    }
    
}
