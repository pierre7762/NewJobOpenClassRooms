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
    private let pm = PersistenceManager()
    
    func getContactsList() {
        contacts = pm.fetchContact()
    }
    
    func deleteContact(id: UUID) {
        pm.removeContact(contactId: id)
        getContactsList()
    }
    
}
