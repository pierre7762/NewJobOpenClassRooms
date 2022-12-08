//
//  AddContactViewModel.swift
//  NewJob
//
//  Created by Pierre on 28/07/2022.
//

import Foundation

class ContactFormViewModel: ObservableObject {
    @Published var favoriteJob: SelectedJob?
    @Published var title = "Votre contact"
    @Published var showingDestinataireSheet = false
    @Published var contactName = ""
    @Published var contactCompagny = ""
    @Published var contactMail = ""
    @Published var contactPhoneNumber = ""
    @Published var contactFunctionInCompany = ""
    @Published var contactArray: [Contact] = []
    var jobId = ""
    
    var pm: PersistenceManager!
    
    func initContact(actualContact: ContactDisplayable?) {
        guard let actualC = actualContact else { return }
        contactName = actualC.name
        contactCompagny = actualC.compagny
        contactMail = actualC.email ?? ""
        contactPhoneNumber = actualC.phoneNumber
        contactFunctionInCompany = actualC.functionInCompany
    }
    
    func actionToDo(actualContact: ContactDisplayable?) {
        guard actualContact != nil else {
            createContact()
            return
        }
        updateContact(actualContact: actualContact!)
    }
    
    func createContact() {
        var jobIdChecked = ""
        if jobId != "" {
            jobIdChecked = jobId
        }
        pm.createContact(
            jobId: jobIdChecked,
            name: contactName,
            compagny: contactCompagny,
            functionInCompany: contactFunctionInCompany,
            contactMail: contactMail,
            contactPhoneNumber: contactPhoneNumber
        )
        showingDestinataireSheet.toggle()
    }
    
    func updateContact(actualContact: ContactDisplayable) {
        pm.updateContact(
            contactId: actualContact.contactId,
            name: contactName,
            compagny: contactCompagny,
            functionInCompany: contactFunctionInCompany,
            contactMail: contactMail,
            contactPhoneNumber: contactPhoneNumber
        )
    }
}
