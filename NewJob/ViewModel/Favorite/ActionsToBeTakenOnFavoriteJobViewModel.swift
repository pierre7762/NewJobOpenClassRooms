//
//  ActionsToBeTakenOnFavoriteJobViewModel.swift
//  NewJob
//
//  Created by Pierre on 25/04/2022.
//

import Foundation
import CoreData

class ActionsToBeTakenOnFavoriteJobViewModel: ObservableObject {

    @Published var favoriteJob: SelectedJob?
    @Published var createCandidacyToggle = false
    @Published var createDateCandidacy: Date = Date()
    @Published var means: String = ""
    @Published var showingDestinataireSheet = false
    @Published var contactName = ""
    @Published var contactCompagny = ""
    @Published var contactMail = ""
    @Published var contactPhoneNumber = ""
    @Published var contactFunctionInCompany = ""
    
    let memoryManager = PersistenceManager()
    
    func toggleCandidacyMake(trueFalse: Bool) {
//        favoriteJob.candidacyMake = trueFalse
        memoryManager.saveData()
    }
    
    func createRemoveCandidady(isCreated: Bool, job: SelectedJob) {
        switch isCreated {
        case true:
//            print("create new candidacy")
            let newCandidacy = Candidacy(context: memoryManager.viewContext)
            newCandidacy.candidacyMeans = ""
            newCandidacy.candidacyDate = Date()
            newCandidacy.comment = "test"
//            favoriteJob!.candidacy?.adding(newCandidacy)
            newCandidacy.selectedJob = favoriteJob
//            print("favoriteJob!.candidacy?.count : ", favoriteJob!.candidacy?.count)
//            print("favoriteJob!.candidacy : ", favoriteJob!.candidacy)
            save()
//            print("new candidacy is created : ", favoriteJob?.candidacy)
//            print("candidacy count : ", favoriteJob?.candidacy?.count)
            
        case false:
            print("remove")
            memoryManager.viewContext.delete(favoriteJob!.candidacy!)
            
//            favoriteJob?.candidacy = nil
            save()
        }
    }
    
    func createCandidacy() {
        let newCandidacy = Candidacy(context: memoryManager.viewContext)
        newCandidacy.candidacyMeans = means
        newCandidacy.candidacyDate = createDateCandidacy
        newCandidacy.comment = "comment"
        newCandidacy.selectedJob = favoriteJob
//        print("favoriteJob!.candidacy : ", favoriteJob!.candidacy)
        save()
    }
    
    func createContact() {
        let newContact = Contact(context: memoryManager.viewContext)
        newContact.name = contactName
        newContact.compagny = contactCompagny
        newContact.functionInCompany = contactFunctionInCompany
        newContact.email = contactMail
        newContact.phoneNumber = contactPhoneNumber
        
        print("new contact : ", newContact)
        
        favoriteJob?.candidacy?.contact?.adding(newContact)
//        newContact.candidacy?.adding((favoriteJob?.candidacy))
        showingDestinataireSheet.toggle()
        save()
        print("favorite job . candidacy.contact: ", favoriteJob?.candidacy?.contact as Any)
        
    }
    
    func save() {
        memoryManager.saveData()
    }
    
    func updateCandidacyDate(newDate: Date) {
//        print(favoriteJob?.candidacy?.count)
//        favoriteJob?.sortedCandidacy[0].candidacyDate = newDate
//        var data : Set<Candidacy> = []
//        for cand in favoriteJob!.sortedCandidacy {
//            data.insert(cand)
//        }
//        favoriteJob?.candidacy = data as NSSet
//        save()
//
//        print("after update : ", favoriteJob?.sortedCandidacy)
        favoriteJob?.candidacy?.candidacyDate = newDate
        save()
//        print("candidature ? ", favoriteJob?.candidacy)
        
    }
    
    
    func candidacyIsCreated(){
        if favoriteJob!.candidacy != nil {
            createCandidacyToggle = true
        } else {
            createCandidacyToggle = false
        }
    }
    
    private func deleteCandidacy(candidacy: Candidacy) {
//        memoryManager.viewContext.delete(favoriteJob.candidacy!)
//        favoriteJob.removeFromCandidacy(candidacy)
        memoryManager.saveData()
    }
}
