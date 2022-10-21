//
//  ContactDetailViewModel.swift
//  NewJob
//
//  Created by Pierre on 21/10/2022.
//

import Foundation

class ContactDetailsViewModel: ObservableObject {
    @Published var showingDestinataireSheet = false
    private let pm = PersistenceManager()
    
    func deleteContact(id: UUID) {
        pm.removeContact(contactId: id)
    }
    
}
