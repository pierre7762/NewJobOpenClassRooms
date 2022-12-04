//
//  AddInterviewViewModel.swift
//  NewJob
//
//  Created by Pierre on 03/12/2022.
//

import Foundation

class AddInterviewViewModel: ObservableObject {
    @Published var createDateInterview: Date = Date()
    @Published var interviewComment: String = ""
    @Published var contactList: [Contact] = []
    @Published var contactSelected: String = "Non précisé"
    var pm = PersistenceManager()
    
    func fetchCandidacyContactList(candidacyId: UUID) {
        let contacts = try! pm.fetchCandidacyContactsList(candidacyID: candidacyId)
        print(contacts)
        contactList = contacts
    }
    
    func createInterview(candidacyId: UUID) {
        var cont: Contact?
        if contactSelected != "Non précisé" {
            do {
                try cont = pm.fetchContactByName(name: contactSelected)
            } catch {
                cont = nil
            }
        }
        pm.createInterview(candidacyID: candidacyId, contact: cont, date: createDateInterview, comment: interviewComment)
    }
    
    func removeInterview(interviewId: UUID) {
        pm.removeInterview(interviewId: interviewId)
    }
}
