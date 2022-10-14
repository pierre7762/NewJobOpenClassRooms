//
//  ActionsToBeTakenOnFavoriteJobViewModel.swift
//  NewJob
//
//  Created by Pierre on 25/04/2022.
//

import Foundation

class ActionsToBeTakenOnFavoriteJobViewModel: ObservableObject {

    @Published var favoriteJob: SelectedJob?
    @Published var dataReady: Bool = false
    @Published var createCandidacyToggle = false
    @Published var createDateCandidacy: Date = Date()
    @Published var means: String = "" {
        didSet {

        }
    }
    @Published var comment: String = ""
    @Published var showingDestinataireSheet = false
    @Published var contactName = ""
    @Published var contactCompagny = ""
    @Published var contactMail = ""
    @Published var contactPhoneNumber = ""
    @Published var contactFunctionInCompany = ""
    @Published var contactArray: [Contact] = []
    @Published var favoriteJobIsInit = false
    
    let memoryManager = PersistenceManager()
    
    func toggleCandidacyMake(trueFalse: Bool) {
//        favoriteJob.candidacyMake = trueFalse
        memoryManager.saveData(from: "ActionsToBeTakenOnFavoriteJobViewModel toggleCAndidacyMake L34")
    }
    
    func initFavoriteJob(job: SelectedJob) {
        favoriteJob = job
        guard let candidacy = job.candidacy else {
            createDateCandidacy = job.candidacy?.candidacyDate ?? Date()
            means = job.candidacy?.candidacyMeans ?? ""
            createCandidacyToggle = false
            print("else")
            return
        }
        print("candidacy = job.candidacy")
        createCandidacyToggle = true

        means = candidacy.candidacyMeans!
        comment = candidacy.comment!
        createDateCandidacy = job.candidacy!.candidacyDate!
        favoriteJobIsInit = true
    }
    
    func createRemoveCandidady(isCreated: Bool) {
        print(" Action vm L 57 => isCreate = ", isCreated)
        guard let job = favoriteJob else { return }
        switch isCreated {
        case true:
            if(favoriteJob?.candidacy == nil) {
                print("favoriteJob?.candidacy == nil")
                memoryManager.createCandidacy(candidacyMeans: means, candidacyDate: createDateCandidacy, comment: "test", favoriteJobId: job.id!)
            }
            
        case false:
            memoryManager.removeCandidacy(favoriteJobId: job.id!)
        }
    }
        
    func updateCandidacy() {
        if favoriteJobIsInit {
            guard let id = favoriteJob?.id else { return }
            guard let candidacy = favoriteJob?.candidacy else { return }
            
            let amendedApplication = checkIfCandidacyFormIsDifferentOfFavoriteJobCandidacy()

            if amendedApplication {
                candidacy.candidacyDate = createDateCandidacy
                candidacy.candidacyMeans = means
                candidacy.comment = comment
                memoryManager.updateSelectedJobCandidacy(id: id, candidacyUpdated: candidacy)

                favoriteJob = try? memoryManager.getSelectedJobWithId(id: id)
            }
        }
    }

    func checkIfCandidacyFormIsDifferentOfFavoriteJobCandidacy() -> Bool {
        guard let candidacy = favoriteJob?.candidacy else { return true}
        
        if candidacy.candidacyDate != createDateCandidacy {
            return true
        }
        if candidacy.candidacyMeans != means {
            return true
        }
        if candidacy.comment != comment {
            return true
        }
        
        return false
    }
    
    func candidacyIsCreated(){
        if favoriteJob!.candidacy != nil {
            createCandidacyToggle = true
        } else {
            createCandidacyToggle = false
        }
    }
    
    private func convertContactSetToContactArray() {
        contactArray = favoriteJob!.candidacy!.contact!.allObjects as! [Contact]
    }
}
