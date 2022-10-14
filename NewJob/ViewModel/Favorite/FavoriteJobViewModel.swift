//
//  FavoriteJobViewModel.swift
//  NewJob
//
//  Created by Pierre on 07/04/2022.
//

import Foundation

class FavoriteJobViewModel: ObservableObject {
    var memoryManager = PersistenceManager()
    
    @Published var jobs: [SelectedJob] = []
    
    init() {
        jobs = memoryManager.fetchSelectedJobs()
    }
    
    func updateJobsList() {
        jobs = memoryManager.fetchSelectedJobs()
    }
    
    func delete(index: Int) {
        memoryManager.viewContext.delete(jobs[index])
        memoryManager.saveData(from: "FavoriteJobViewModel delete() L25")
    }
}
