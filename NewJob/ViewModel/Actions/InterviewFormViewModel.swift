//
//  AddInterviewViewModel.swift
//  NewJob
//
//  Created by Pierre on 03/12/2022.
//

import Foundation

class InterviewFormViewModel: ObservableObject {
    @Published var createDateInterview: Date = Date()
    @Published var interviewComment: String = ""
    @Published var contactList: [Contact] = []
    @Published var contactSelected: String = "Non précisé"
    var pm: PersistenceManager!
    
    func initInterviewForm(candidacyId: UUID, interview: Interview?) {
        fetchCandidacyContactList(candidacyId: candidacyId)
        if interview != nil {
            createDateInterview = (interview?.date)!
            interviewComment = (interview?.comment)!
            contactSelected = interview?.contact?.name ?? "Non précisé"
        }
    }
    
    func fetchCandidacyContactList(candidacyId: UUID) {
        let contacts = pm.fetchCandidacyContactsList(candidacyID: candidacyId)
        print(contacts)
        contactList = contacts
    }
    
    func actionToDo(candidacyID: UUID?, interviewId: UUID?) {
        if interviewId != nil {
            updateInterview(interViewId: interviewId!)
        } else {
            createInterview(candidacyId: candidacyID!)
        }
    }
    
    func createInterview(candidacyId: UUID) {
        var cont: Contact?
        if contactSelected != "Non précisé" {            
            try? cont = pm.fetchContactByName(name: contactSelected)
        }
        pm.createInterview(candidacyID: candidacyId, contact: cont, date: createDateInterview, comment: interviewComment)
    }
    
    func removeInterview(interviewId: UUID) {
        pm.removeInterview(interviewId: interviewId)
    }
    
    func getContactOrNil() -> Contact? {
        var cont: Contact?
        if contactSelected != "Non précisé" {
            cont = try! pm.fetchContactByName(name: contactSelected)
        }
        return cont
    }
    
    func updateInterview(interViewId: UUID) {
        let cont = getContactOrNil()
        pm.updateInterview(
            interviewId: interViewId,
            contact: cont,
            date: createDateInterview,
            comment: interviewComment
        )
    }
}
