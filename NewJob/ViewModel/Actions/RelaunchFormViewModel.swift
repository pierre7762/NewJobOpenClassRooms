//
//  AddRelaunchViewModel.swift
//  NewJob
//
//  Created by Pierre on 28/10/2022.
//

import Foundation

class RelaunchFormViewModel: ObservableObject{
    @Published var createDateRelaunch: Date = Date()
    @Published var means: String = "Non précisé"
    @Published var comment: String = ""
    @Published var contactList: [Contact] = []
    @Published var contactSelected: String = "Non précisé"
    
    var pm: PersistenceManager!
    
    func initRelaunch(currentRelaunch: Relaunch?) {   
        guard let actualR = currentRelaunch else { return }
        createDateRelaunch = actualR.date!
        means = actualR.means!
        contactSelected = actualR.contact?.name ?? "Non précisé"
        comment = actualR.comment!
    }
    
    func fetchCandidacyContactList(candidacyId: UUID) {
        var contacts: [Contact] = []
        contacts = pm.fetchCandidacyContactsList(candidacyID: candidacyId)
        contactList = contacts
    }
    
    func actionToDo(candidacyID: UUID?, relaunchId: UUID?) {
        if relaunchId != nil {
            updateRelaunch(relaunchId: relaunchId!)
        } else {
            createRelaunch(candidacyID: candidacyID!)
        }
    }
    
    func getContactOrNil() -> Contact? {
        var cont: Contact?
        if contactSelected != "Non précisé" {
            cont = try! pm.fetchContactByName(name: contactSelected)
        }
        return cont
    }
    
    func createRelaunch(candidacyID: UUID) {
        let cont = getContactOrNil()
        pm.createRelaunch(
            candidacyID: candidacyID,
            contact: cont,
            date: createDateRelaunch,
            comment: comment,
            means: means
        )
    }
    
    func updateRelaunch(relaunchId: UUID) {
        let cont = getContactOrNil()
        pm.updateRelaunch(
            relaunchId: relaunchId,
            contact: cont,
            date: createDateRelaunch,
            comment: comment,
            means: means
        )
    }
}

