//
//  ContactViewModel.swift
//  NewJob
//
//  Created by Pierre on 07/07/2022.
//

import Foundation

class ContactViewModel: ObservableObject {
    @Published var contacts: [Contact] = []
    private let pm = PersistenceManager()
    
    func getContactsList() {
        contacts = pm.fetchContact()
    }
    
}

