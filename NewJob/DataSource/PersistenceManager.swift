//
//  PersistenceController.swift
//  NewJob
//
//  Created by Pierre on 22/04/2022.
//

import Foundation
import CoreData

struct PersistenceManager {
    // MARK: Properties
    private let coreDataStack: CoreDataStack
    private let viewContext: NSManagedObjectContext
    // MARK: Initializer

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.viewContext = coreDataStack.mainContext
    }
    
//    static let shared = PersistenceManager()
//    var viewContext: NSManagedObjectContext {
//        return PersistenceManager.shared.container.viewContext
//    }
//    
//    let appName = "NewJob"
//    let urlPath = "/dev/null"
//    let container: NSPersistentContainer
//    
//    init(inMemory: Bool = false) {
//        container = NSPersistentContainer(name: appName)
//        if inMemory {
//            let stores = container.persistentStoreDescriptions
//            if let first = stores.first {
//                first.url = URL(fileURLWithPath: urlPath)
//            }
//        }
//        container.viewContext.automaticallyMergesChangesFromParent = true
//        container.loadPersistentStores(completionHandler: loadCompletion)
//    }
//    
//    func loadCompletion(store: NSPersistentStoreDescription, error: Error?) {
//        if let e = error {
//            print(e.localizedDescription)
//        }
//    }
    
    func saveData() {
        do {
            try viewContext.save()
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    // marks : SelectedJob
    func createSelectedJob(job: Resultat) {
        
        let selectedJob = SelectedJob(context: viewContext)
        let workplace = Workplace(context: viewContext)
        workplace.city = job.lieuTravail.commune
        workplace.posteCode = job.lieuTravail.codepostal
        workplace.libelle = job.lieuTravail.libelle
        workplace.longitude = job.lieuTravail.longitude ?? 0.0
        workplace.latitude = job.lieuTravail.latitude ?? 0.0
        
        let originOffers = OriginOffers(context: viewContext)
        originOffers.origin = job.origineOffre.origine
        originOffers.urlOrigin = job.origineOffre.urlOrigine
        originOffers.partnerName = job.origineOffre.partenaires[0].nom
        originOffers.partnerLogo = job.origineOffre.partenaires[0].logo
        originOffers.partnerUrl = job.origineOffre.partenaires[0].url
        
        let salary = Salary(context: viewContext)
        salary.comment = job.salaire.commentaire
        salary.firstComplement = job.salaire.complement1
        salary.secondComplement = job.salaire.complement2
        salary.libelle = job.salaire.libelle
        
        selectedJob.id = job.id
        selectedJob.creationDate = job.dateCreation
        selectedJob.appelationWording = job.appellationlibelle
        selectedJob.entitled = job.intitule
        selectedJob.jobDescription = job.resultatDescription
        selectedJob.workplace = workplace
        selectedJob.originOffers = originOffers
        selectedJob.salary = salary
        
        saveData()
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
    
    func removeSelectedJob(selectedJobId: String) {
        var jobs: [SelectedJob] = []
        let request = NSFetchRequest<SelectedJob>(entityName: "SelectedJob")
        request.predicate = NSPredicate(format: "id == %@", selectedJobId)
        do {
            jobs = try viewContext.fetch(request)
            guard let job = jobs.first else { return }
            viewContext.delete(job)
            saveData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // marks : Candidacy
//    func updateSelectedJobCandidacyDate(id: String, date: Date) {
//        var jobs: [SelectedJob] = []
//        let request = NSFetchRequest<SelectedJob>(entityName: "SelectedJob")
//        request.predicate = NSPredicate(format: "id == %@", id)
//        do {
//            jobs = try viewContext.fetch(request)
//            guard let job = jobs.first else { return }
//            job.candidacy?.candidacyDate = date
//            saveData()
//            
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
    
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
            candidacy.result = "En cours"
            
            saveData()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func removeCandidacy(favoriteJobId: String) {
        var jobs: [SelectedJob] = []
        let request = NSFetchRequest<SelectedJob>(entityName: "SelectedJob")
        request.predicate = NSPredicate(format: "id == %@", favoriteJobId)
        do {
            jobs = try viewContext.fetch(request)
            guard let job = jobs.first else { return }
            viewContext.delete(job.candidacy!)
            saveData()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateSelectedJobCandidacy(jobId: String, candidacyDate: Date?, candidacyMeans: String?, comment: String?, result: String? ) {
        var jobs: [SelectedJob] = []
        let request = NSFetchRequest<SelectedJob>(entityName: "SelectedJob")
        request.predicate = NSPredicate(format: "id == %@", jobId)
        do {
            jobs = try viewContext.fetch(request)
            guard let job = jobs.first else { return }
            job.candidacy?.candidacyDate = candidacyDate ?? job.candidacy?.candidacyDate
            job.candidacy?.candidacyMeans = candidacyMeans ?? job.candidacy?.candidacyMeans
            job.candidacy?.comment = comment ?? job.candidacy?.comment
            job.candidacy?.result = result ?? job.candidacy?.result
            
            saveData()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchAllCandidacies() -> [Candidacy] {
        var candidacies: [Candidacy] = []
        let request = NSFetchRequest<Candidacy>(entityName: "Candidacy")
        do {
            candidacies = try viewContext.fetch(request)
            return candidacies
        } catch {
            print(error.localizedDescription)
            return []
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
        
        saveData()
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
    
    func fetchContactById(contactId: UUID) throws -> Contact {
        var contacts: [Contact] = []
        let request = NSFetchRequest<Contact>(entityName: "Contact")
        request.predicate = NSPredicate(format: "id == %@", contactId as CVarArg)
        do {
            contacts = try viewContext.fetch(request)
            return contacts.first!
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    func removeContact(contactId: UUID) {
        var contacts: [Contact] = []
        let request = NSFetchRequest<Contact>(entityName: "Contact")
        request.predicate = NSPredicate(format: "id == %@", contactId as CVarArg)
        do {
            contacts = try viewContext.fetch(request)
            guard let contact = contacts.first else { return }
            viewContext.delete(contact)
            saveData()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
//    func updateContact(contactId: UUID, name: String) {
//        var contacts: [Contact] = []
//        let request = NSFetchRequest<Contact>(entityName: "Contact")
//        request.predicate = NSPredicate(format: "id == %@", contactId as CVarArg)
//        do {
//            contacts = try viewContext.fetch(request)
//            guard let contact = contacts.first else { return }
//            contact.name = name
//            saveData()
//
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
    
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
    
    func fetchContactByName(name: String) throws -> Contact{
        let request = NSFetchRequest<Contact>(entityName: "Contact")
        request.predicate = NSPredicate(format: "name == %@", name)
        do {
            let contacts = try viewContext.fetch(request)
            print("contacts.first! : ", contacts.first!)
            return contacts.first!
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    func fetchCandidacyContactsList(candidacyID: UUID) throws -> [Contact]{
        var candidacies: [Candidacy] = []
        let request = NSFetchRequest<Candidacy>(entityName: "Candidacy")
        request.predicate = NSPredicate(format: "id == %@", candidacyID as CVarArg)
        do {
            candidacies = try viewContext.fetch(request)
            let candidacy = candidacies.first
            return candidacy?.contact?.allObjects as! [Contact]
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    func fetchAllCandidaciesOfContact(contactId: UUID) -> [Candidacy]{
        var contacts: [Contact] = []
        let request = NSFetchRequest<Contact>(entityName: "Contact")
        request.predicate = NSPredicate(format: "id == %@", contactId as CVarArg)
        
        do {
            contacts = try viewContext.fetch(request)
            let contact = contacts.first
            
            //            return candidacy?.relaunch?.allObjects as! [Relaunch]
            return contact?.candidacy?.allObjects as! [Candidacy]
        } catch  {
            print(error.localizedDescription)
            return []
        }
    }
    
    // marks : Relaunch
    func createRelaunch(candidacyID: UUID, contact: Contact?, date: Date, comment: String, means: String) {
        var candidacies: [Candidacy] = []
        let request = NSFetchRequest<Candidacy>(entityName: "Candidacy")
        request.predicate = NSPredicate(format: "id == %@", candidacyID as CVarArg)
        do {
            candidacies = try viewContext.fetch(request)
            let candidacy = candidacies.first
            
            let relaunch = Relaunch(context: viewContext)
            relaunch.id = UUID()
            relaunch.contact = contact
            relaunch.date = date
            relaunch.comment = comment
            relaunch.means = means
            relaunch.candidacy = candidacy
            
            saveData()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchAllRelaunchesfromCandidacyId(candidacyId: UUID, ascendingDate: Bool) -> [Relaunch] {
        let request = NSFetchRequest<Relaunch>(entityName: "Relaunch")
        request.predicate = NSPredicate(format: "candidacy.id == %@", candidacyId as CVarArg)
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Relaunch.date), ascending: ascendingDate)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            let relaunches = try viewContext.fetch(request)
            return relaunches
        } catch  {
            print(error.localizedDescription)
            return []
        }
    }
    
    func removeRelaunch(relaunchId: UUID) {
        var relaunches: [Relaunch] = []
        let request = NSFetchRequest<Relaunch>(entityName: "Relaunch")
        request.predicate = NSPredicate(format: "id == %@", relaunchId as CVarArg)
        do {
            relaunches = try viewContext.fetch(request)
            guard let relaunch = relaunches.first else { return }
            viewContext.delete(relaunch)
            saveData()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // marks : Interview
    func createInterview(candidacyID: UUID, date: Date, comment: String) {
        var candidacies: [Candidacy] = []
        let request = NSFetchRequest<Candidacy>(entityName: "Candidacy")
        request.predicate = NSPredicate(format: "id == %@", candidacyID as CVarArg)
        do {
            candidacies = try viewContext.fetch(request)
            let candidacy = candidacies.first
            
            let interview = Interview(context: viewContext)
            interview.id = UUID()
            interview.date = date
            interview.comment = comment
            interview.candidacy = candidacy
            
            saveData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchAllInterviews() -> [Interview] {
        var interviews: [Interview] = []
        let request = NSFetchRequest<Interview>(entityName: "Interview")
        do {
            interviews = try viewContext.fetch(request)
            return interviews
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func removeInterview(interviewId: UUID) {
        var interviews: [Interview] = []
        let request = NSFetchRequest<Interview>(entityName: "Interview")
        request.predicate = NSPredicate(format: "id == %@", interviewId as CVarArg)
        do {
            interviews = try viewContext.fetch(request)
            guard let interview = interviews.first else { return }
            viewContext.delete(interview)
            saveData()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // marks : ActionsToBeTaken
    func fetchAllInterviewFromCandidacyId(candidacyId: UUID, ascendingDate: Bool) -> [Interview] {
        let request = NSFetchRequest<Interview>(entityName: "Interview")
        request.predicate = NSPredicate(format: "candidacy.id == %@", candidacyId as CVarArg)
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Interview.date), ascending: ascendingDate)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            let interviews = try viewContext.fetch(request)
            return interviews
        } catch  {
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
