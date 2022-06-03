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
//            print("create new candidacy")
            let newCandidacy = Candidacy(context: memoryManager.viewContext)
            newCandidacy.candidacyMeans = ""
            newCandidacy.candidacyDate = Date()
            newCandidacy.comment = "test"
//            favoriteJob!.candidacy?.adding(newCandidacy)
            newCandidacy.selectedJob = favoriteJob
            print("favoriteJob!.candidacy?.count : ", favoriteJob!.candidacy?.count)
            save()
//            print("new candidacy is created : ", favoriteJob?.candidacy)
//            print("candidacy count : ", favoriteJob?.candidacy?.count)
            
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
        print(favoriteJob?.candidacy?.count)
//        favoriteJob?.sortedCandidacy[0].candidacyDate = newDate
//        var data : Set<Candidacy> = []
//        for cand in favoriteJob!.sortedCandidacy {
//            data.insert(cand)
//        }
//        favoriteJob?.candidacy = data as NSSet
//        save()
//
//        print("after update : ", favoriteJob?.sortedCandidacy)
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
