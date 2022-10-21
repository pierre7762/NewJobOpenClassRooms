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
    
    func saveData(from: String) {
        print("saveData from : ", from)
        do {
            try viewContext.save()
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    // marks : SelectedJob
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
    
    func getSelectedJobWithId(id: String) throws -> SelectedJob {
        var jobs: [SelectedJob] = []
        let request = NSFetchRequest<SelectedJob>(entityName: "SelectedJob")
        request.predicate = NSPredicate(format: "id == %@", id)
        do {
            jobs = try viewContext.fetch(request)
            return jobs.first!
        } catch {
            print(error.localizedDescription)
            throw error
        }

    }
    
    func checkIfIsFavoriteResultat(job: Resultat) -> Bool {
        let request = NSFetchRequest<SelectedJob>(entityName: "SelectedJob")
        var favorite: Bool = false
        do {
            let favoriteJobList = try viewContext.fetch(request)
            favoriteJobList.forEach {
                if $0.originOffers?.urlOrigin == job.origineOffre.urlOrigine {
                    favorite = true
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return favorite
    }
    
    func checkIfIsFavoriteSelectedJob(job: SelectedJob) -> Bool {
        let request = NSFetchRequest<SelectedJob>(entityName: "SelectedJob")
        var favorite: Bool = false
        do {
            let favoriteJobList = try viewContext.fetch(request)
            favoriteJobList.forEach {
                if $0.originOffers?.urlOrigin == job.originOffers?.urlOrigin {
                    favorite = true
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return favorite
    }
    
    // marks : Candidacy
    func updateSelectedJobCandidacyDate(id: String, date: Date) {
        var jobs: [SelectedJob] = []
        let request = NSFetchRequest<SelectedJob>(entityName: "SelectedJob")
        request.predicate = NSPredicate(format: "id == %@", id)
        do {
            jobs = try viewContext.fetch(request)
            guard let job = jobs.first else { return }
            job.candidacy?.candidacyDate = date
            saveData(from: "persistance manager updateSelectedJobCandidacyDate() L119")
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createCandidacy(candidacyMeans: String, candidacyDate: Date, comment: String, favoriteJobId: String) {
        var jobs: [SelectedJob] = []
        let request = NSFetchRequest<SelectedJob>(entityName: "SelectedJob")
        request.predicate = NSPredicate(format: "id == %@", favoriteJobId)
        do {
            jobs = try viewContext.fetch(request)
            guard let favoriteJob = jobs.first else { return }
            let candidacy = Candidacy(context: viewContext)
            candidacy.candidacyMeans = candidacyMeans
            candidacy.candidacyDate = candidacyDate
            candidacy.comment = comment
            candidacy.selectedJob = favoriteJob
            candidacy.id = UUID()

            saveData(from: "persistance manager createCandidacy() L142")
            
        } catch {
            print(error.localizedDescription)
        }

//        let candidacy = Candidacy(context: viewContext)
//        candidacy.candidacyMeans = candidacyMeans
//        candidacy.candidacyDate = candidacyDate
//        candidacy.comment = comment
//        candidacy.selectedJob = favoriteJob
//        candidacy.id = UUID()
//
//        saveData(from: "persistance manager createCandidacy() L136")
    }
    
    func removeCandidacy(favoriteJobId: String) {
        var jobs: [SelectedJob] = []
        let request = NSFetchRequest<SelectedJob>(entityName: "SelectedJob")
        request.predicate = NSPredicate(format: "id == %@", favoriteJobId)
        do {
            jobs = try viewContext.fetch(request)
            guard let job = jobs.first else { return }
            viewContext.delete(job.candidacy!)
            saveData(from: "persistance manager updateSelectedJobCandidacyDate() L147")
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateSelectedJobCandidacy(id: String, candidacyUpdated: Candidacy) {
        var jobs: [SelectedJob] = []
        let request = NSFetchRequest<SelectedJob>(entityName: "SelectedJob")
        request.predicate = NSPredicate(format: "id == %@", id)
        do {
            jobs = try viewContext.fetch(request)
            guard let job = jobs.first else { return }
            job.candidacy = candidacyUpdated
            

            saveData(from: "persistance manager updateSelectedJobCandidacy() L169")
            
        } catch {
            print(error.localizedDescription)
        }
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
    
    // marks : Contact
    func createContact(jobId: String, name: String, compagny: String, functionInCompany: String, contactMail: String, contactPhoneNumber: String) {
        
        let newContact = Contact(context: viewContext)
        newContact.name = name
        newContact.id = UUID()
        newContact.compagny = compagny
        newContact.functionInCompany = functionInCompany
        newContact.email = contactMail
        newContact.phoneNumber = contactPhoneNumber
        
        if jobId != "" {
            let job = try? getSelectedJobWithId(id: jobId)
            newContact.addToCandidacy(job!.candidacy!)
            job!.candidacy?.addToContact(newContact)
        }
        
        saveData(from: "persistance manager createContact() 200")
    }
    
    func fetchContact() -> [Contact] {
        var contacts: [Contact] = []
        let request = NSFetchRequest<Contact>(entityName: "Contact")
        let sortByCreationDate  = NSSortDescriptor(keyPath: \Contact.name, ascending: true)
        request.sortDescriptors = [sortByCreationDate]
        do {
            contacts = try viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        return contacts
    }
    
    func removeContact(contactId: UUID) {
        var contacts: [Contact] = []
        let request = NSFetchRequest<Contact>(entityName: "Contact")
        request.predicate = NSPredicate(format: "id == %@", contactId as CVarArg)
        do {
            contacts = try viewContext.fetch(request)
            guard let contact = contacts.first else { return }
            viewContext.delete(contact)
            saveData(from: "persistance manager removeContact() L241")
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchContactWhoStartBy(name: String) -> [Contact]{
        let request = NSFetchRequest<Contact>(entityName: "Contact")
        request.predicate = NSPredicate(format: "name contains[c] %@", name)
        do {
            let contacts = try viewContext.fetch(request)
            return contacts
        } catch {
            print(error.localizedDescription)
            return []
        }
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
