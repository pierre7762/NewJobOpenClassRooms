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
//    @Published var createCandidacyToggle: Bool {
//        return candidacyIsCreated()
//    }
    

    let memoryManager = PersistenceManager()
    
    func toggleCandidacyMake(trueFalse: Bool) {
//        favoriteJob.candidacyMake = trueFalse
        memoryManager.saveData()
    }
    
    func createRemoveCandidady(isCreated: Bool, job: SelectedJob) {
        switch isCreated {
        case true:
            let newCandidacy = Candidacy(context: memoryManager.viewContext)
            newCandidacy.candidacyMeans = ""
            newCandidacy.candidacyDate = Date()
            newCandidacy.comment = "test"
            job.candidacy?.adding(newCandidacy)
            
        case false:
            print("remove")
            job.removeFromCandidacy(job.candidacy!)
            save()
        }
    }
    
    func save() {
        memoryManager.saveData()
    }
    
    func updateCandidacyDate(newDate: Date) {
//        let sortedCandidacy = favoriteJob!.candidacy!.sorted{$0.candidacyDate > $1.candidacydate}
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
