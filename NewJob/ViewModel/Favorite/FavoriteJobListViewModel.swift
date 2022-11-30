//
//  FavoriteJobViewModel.swift
//  NewJob
//
//  Created by Pierre on 07/04/2022.
//

import Foundation

class FavoriteJobListViewModel: ObservableObject {
    var pm = PersistenceManager(coreDataStack: CoreDataStack(modelName: "NewJob"))
    
    @Published var jobs: [SelectedJob] = []
    
    init() {
        jobs = pm.fetchSelectedJobs()
    }
    
    func updateJobsList() {
        jobs = pm.fetchSelectedJobs()
    }
    
    func delete(job: SelectedJob) {
        pm.removeSelectedJob(selectedJobId: job.id!)
        updateJobsList()
    }
}
