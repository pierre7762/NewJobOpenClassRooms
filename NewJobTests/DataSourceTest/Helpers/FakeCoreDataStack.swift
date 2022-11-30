//
//  FakeCoreDataStack.swift
//  NewJobTests
//
//  Created by Pierre on 28/11/2022.
//

@testable import NewJob
import CoreData

final class FakeCoreDataStack: CoreDataStack {

    // MARK: - Initializer
    convenience init() {
        self.init(modelName: "NewJob")
    }

    override init(modelName: String) {
        super.init(modelName: modelName)
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: modelName)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.persistentContainer = container
    }
}
