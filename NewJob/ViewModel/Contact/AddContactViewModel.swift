//
//  AddContactViewModel.swift
//  NewJob
//
//  Created by Pierre on 28/07/2022.
//

import Foundation

class AddContactViewModel: ObservableObject {
    @Published var favoriteJob: SelectedJob?
    @Published var title = "Ajouter votre contact"
    @Published var showingDestinataireSheet = false
    @Published var contactName = ""
    @Published var contactCompagny = ""
    @Published var contactMail = ""
    @Published var contactPhoneNumber = ""
    @Published var contactFunctionInCompany = ""
    @Published var contactArray: [Contact] = []
    var jobId = ""
    
//    var pm = PersistenceManager(coreDataStack: CoreDataStack(modelName: "NewJob"))
//    var pm = PersistenceManager()
    var pm: PersistenceManager!
    
    func initFavoriteJob(job: SelectedJob) {
        favoriteJob = job
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
}
