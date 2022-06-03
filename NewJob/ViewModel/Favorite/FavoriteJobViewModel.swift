//
//  FavoriteJobViewModel.swift
//  NewJob
//
//  Created by Pierre on 07/04/2022.
//

import Foundation
import CoreData

class FavoriteJobViewModel: ObservableObject {
    var memoryManager = PersistenceManager()
    
    @Published var jobs: [SelectedJob] = []
    
    init() {
        fetchSelectedJobs()
    }
    
    func convertToSelectedJobArray() {
        
    }
    
    func delete(index: Int) {
        memoryManager.viewContext.delete(jobs[index])
        memoryManager.saveData()
        fetchSelectedJobs()
    }
    
    func fetchSelectedJobs() {
        jobs = []
        let request = NSFetchRequest<SelectedJob>(entityName: "SelectedJob")
        let sortByCreationDate  = NSSortDescriptor(keyPath: \SelectedJob.creationDate, ascending: true)
        request.sortDescriptors = [sortByCreationDate]
        do {
            self.jobs = try memoryManager.viewContext.fetch(request)
//            print("save job count : ", self.jobs.count)
//            print(self.jobs[0].candidacyMake)
            print(self.jobs)

        } catch {
            print(error.localizedDescription)
        }
    }
    
}
