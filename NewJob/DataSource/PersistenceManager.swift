//
//  PersistenceController.swift
//  NewJob
//
//  Created by Pierre on 22/04/2022.
//

import Foundation
import CoreData

struct PersistenceManager {
    
    static let shared = PersistenceManager()
    var viewContext: NSManagedObjectContext {
        return PersistenceManager.shared.container.viewContext
    }
    
    let appName = "NewJob"
    let urlPath = "/dev/null"
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: appName)
        if inMemory {
            let stores = container.persistentStoreDescriptions
            if let first = stores.first {
                first.url = URL(fileURLWithPath: urlPath)
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: loadCompletion)
    }
    
    func loadCompletion(store: NSPersistentStoreDescription, error: Error?) {
        if let e = error {
            print(e.localizedDescription)
        }
    }
    
    func saveData() {
        do {
            try viewContext.save()
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    func fetchSelectedJobs() -> [SelectedJob] {
        var jobs: [SelectedJob] = []
        let request = NSFetchRequest<SelectedJob>(entityName: "SelectedJob")
        let sortByCreationDate  = NSSortDescriptor(keyPath: \SelectedJob.creationDate, ascending: true)
        request.sortDescriptors = [sortByCreationDate]
        do {
            jobs = try viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        return jobs
    }
    
    func fetchSelectedJobWhoHaveCandidacyMake(jobs: [SelectedJob]) -> [SelectedJob]{
        var selectedJobWhoHaveCandidacyMake: [SelectedJob] = []
        jobs.forEach { job in
            if job.candidacy != nil {
                selectedJobWhoHaveCandidacyMake.append(job)
            }
        }
        
        return selectedJobWhoHaveCandidacyMake
    }
    
}


public extension NSManagedObject {

    //remove issue Multiple NSEntityDescriptions claim the NSManagedObject subclass
    // find on : https://github.com/drewmccormack/ensembles/issues/275
    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }

}
