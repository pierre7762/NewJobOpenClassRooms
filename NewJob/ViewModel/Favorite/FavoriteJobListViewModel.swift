//
//  FavoriteJobViewModel.swift
//  NewJob
//
//  Created by Pierre on 07/04/2022.
//

import Foundation

class FavoriteJobListViewModel: ObservableObject {
    @Published var searchOptions: [String] = ["En cours", "Toutes","Validée","Rejetée"]
    @Published var searchOptionSelected = "En cours"
    var pm = PersistenceManager()
    
    @Published var jobsWithCandidacy: [SelectedJob] = []
    @Published var jobsWithoutCandidacy: [SelectedJob] = []
    @Published var showProgressView: Bool = false
    
    func updateJobsList() {
        showProgressView = true
        if searchOptionSelected == "Toutes" {
            jobsWithCandidacy = pm.fetchSelectedJobsWithCandidacy()
        } else {
            jobsWithCandidacy = pm.fetchSelectedJobsByState(candidacyState: searchOptionSelected)
        }
        jobsWithoutCandidacy = pm.fetchSelectedJobsWhithoutCandidacy()
        showProgressView = false
    }
}
