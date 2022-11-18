//
//  AddRelaunchViewModel.swift
//  NewJob
//
//  Created by Pierre on 28/10/2022.
//

import Foundation

class AddRelaunchViewModel: ObservableObject{
//    @Published var isCreateOrModify:CreateOrModify = .create
    @Published var createDateRelaunch: Date = Date()
    @Published var means: String = "Non précisé"
    @Published var comment: String = ""
    @Published var contactList: [Contact] = []
    @Published var contactSelected: String = "Non précisé"
    
    let pm = PersistenceManager()
    
    init(isCreateOrModify: CreateOrModify, relaunch: Relaunch?) {
        if relaunch != nil {
            self.createDateRelaunch = (relaunch?.date)!
            self.means = (relaunch?.means)!
        }
    }
    
    func fetchCandidacyContactList(candidacyId: UUID) {
        var contacts: [Contact] = []
        contacts = try! pm.fetchCandidacyContactsList(candidacyID: candidacyId)
        
        contactList = contacts
    }
    
    func createRelaunch(candidacyID: UUID) {
        var cont: Contact?
        if contactSelected != "Non précisé" {
            do {
                try cont = pm.fetchContactByName(name: contactSelected)
            } catch {
                cont = nil
            }
        }
        
        pm.createRelaunch(candidacyID: candidacyID, contact: cont, date: createDateRelaunch, comment: comment, means: means)
    }
}

enum CreateOrModify {
    case create
    case modify
}
