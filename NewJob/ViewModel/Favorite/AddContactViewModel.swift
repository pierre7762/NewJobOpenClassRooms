//
//  AddContactViewModel.swift
//  NewJob
//
//  Created by Pierre on 28/07/2022.
//

import Foundation

class AddContactViewModel: ObservableObject {
    @Published var favoriteJob: SelectedJob?

    @Published var showingDestinataireSheet = false
    @Published var contactName = ""
    @Published var contactCompagny = ""
    @Published var contactMail = ""
    @Published var contactPhoneNumber = ""
    @Published var contactFunctionInCompany = ""
    @Published var contactArray: [Contact] = []
    @Published var searchContactPredicat: [Contact] = []
    var jobId = ""
    
    let memoryManager = PersistenceManager()
    
    func initFavoriteJob(job: SelectedJob) {
        favoriteJob = job
//        guard let candidacy = job.candidacy else { return }
       
    }
    
    func createContact() {
        memoryManager.createContact(
            jobId: jobId,
            name: contactName,
            compagny: contactCompagny,
            functionInCompany: contactFunctionInCompany,
            contactMail: contactMail,
            contactPhoneNumber: contactPhoneNumber
        )
        showingDestinataireSheet.toggle()
    }
    
    func searchCompatibleContactName(name: String) {
        searchContactPredicat = memoryManager.fetchContactWhoStartBy(name: name)
        print("searchContactPredicat : ", searchContactPredicat)
    }
    
    func affectResultSearchContactInForm(contact: Contact) {
        guard let n = contact.name else { return }
        contactName = n
        
        searchContactPredicat = []
    }
    
    private func convertContactSetToContactArray() {
        contactArray = favoriteJob!.candidacy!.contact!.allObjects as! [Contact]
    }
}
