//
//  PersistenceController.swift
//  NewJob
//
//  Created by Pierre on 22/04/2022.
//

import Foundation
import CoreData

class PersistenceManager: ObservableObject {
    // MARK: Properties
    //    static let shared = PersistenceManager()
    var viewContext: NSManagedObjectContext {
        return self.container.viewContext
    }
    
    let appName = "NewJob"
    let urlPath = "/dev/null"
    let container: NSPersistentContainer
    
    // MARK: Initializer
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
            try self.container.viewContext.save()
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    // MARK: SelectedJob
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
    
    func fetchSelectedJobs(onlyInProgress: Bool) -> [SelectedJob] {
        let request = NSFetchRequest<SelectedJob>(entityName: "SelectedJob")
        let sortByCreationDate  = NSSortDescriptor(keyPath: \SelectedJob.creationDate, ascending: false)
        if onlyInProgress {
            request.predicate = NSPredicate(format: "candidacy.state == 'En cours'")
        }
        request.sortDescriptors = [sortByCreationDate]
        guard let jobs = try? viewContext.fetch(request) else {return []}
        return jobs
    }
    
    func fetchSelectedJobsWithCandidacy() -> [SelectedJob] {
        let request = NSFetchRequest<SelectedJob>(entityName: "SelectedJob")
        request.predicate = NSPredicate(format: "candidacy != nil")
        let sortByCreationDate  = NSSortDescriptor(keyPath: \SelectedJob.creationDate, ascending: false)
        request.sortDescriptors = [sortByCreationDate]
        guard let jobs = try? viewContext.fetch(request) else { return [] }
        return jobs
    }
    
    func fetchSelectedJobsByState(candidacyState: String) -> [SelectedJob] {
        let request = NSFetchRequest<SelectedJob>(entityName: "SelectedJob")
        request.predicate = NSPredicate(format: "candidacy.state == %@", candidacyState)
        let sortByCreationDate  = NSSortDescriptor(keyPath: \SelectedJob.creationDate, ascending: false)
        request.sortDescriptors = [sortByCreationDate]
        guard let jobs = try? viewContext.fetch(request) else { return [] }
        return jobs
    }
    
    func fetchSelectedJobsWhithoutCandidacy() -> [SelectedJob] {
        let request = NSFetchRequest<SelectedJob>(entityName: "SelectedJob")
        request.predicate = NSPredicate(format: "candidacy == nil")
        let sortByCreationDate  = NSSortDescriptor(keyPath: \SelectedJob.creationDate, ascending: false)
        request.sortDescriptors = [sortByCreationDate]
        guard let jobs = try? viewContext.fetch(request) else { return [] }
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
        guard let favoriteJobList = try? viewContext.fetch(request) else {  return false }
        favoriteJobList.forEach {
            if $0.originOffers?.urlOrigin == job.origineOffre.urlOrigine {
                favorite = true
            }
        }
        return favorite
    }
    
    func checkIfIsFavoriteSelectedJob(job: SelectedJob) -> Bool {
        let request = NSFetchRequest<SelectedJob>(entityName: "SelectedJob")
        var favorite: Bool = false
        guard let favoriteJobList = try? viewContext.fetch(request) else { return false }
        favoriteJobList.forEach {
            if $0.originOffers?.urlOrigin == job.originOffers?.urlOrigin {
                favorite = true
            }
        }
        return favorite
    }
    
    func removeSelectedJob(selectedJobId: String) {
        let request = NSFetchRequest<SelectedJob>(entityName: "SelectedJob")
        request.predicate = NSPredicate(format: "id == %@", selectedJobId)
        guard let jobs = try? viewContext.fetch(request) else { return }
        guard let job = jobs.first else { return }
        viewContext.delete(job)
        saveData()
    }
    
    // MARK: Candidacy
    func createCandidacy(candidacyMeans: String, candidacyDate: Date, comment: String, favoriteJobId: String) {
        let request = NSFetchRequest<SelectedJob>(entityName: "SelectedJob")
        request.predicate = NSPredicate(format: "id == %@", favoriteJobId)
        guard let jobs = try? viewContext.fetch(request) else { return }
        guard let favoriteJob = jobs.first else { return }
        let candidacy = Candidacy(context: viewContext)
        candidacy.candidacyMeans = candidacyMeans
        candidacy.candidacyDate = candidacyDate
        candidacy.comment = comment
        candidacy.selectedJob = favoriteJob
        candidacy.id = UUID()
        candidacy.state = "En cours"
        saveData()
    }
    
    func removeCandidacy(favoriteJobId: String) {
        let request = NSFetchRequest<SelectedJob>(entityName: "SelectedJob")
        request.predicate = NSPredicate(format: "id == %@", favoriteJobId)
        guard let jobs = try? viewContext.fetch(request) else { return }
        guard let job = jobs.first else { return }
        viewContext.delete(job.candidacy!)
        saveData()
    }
    
    func updateSelectedJobCandidacy(jobId: String, candidacyDate: Date?, candidacyMeans: String?, comment: String?, state: String? ) {
        let request = NSFetchRequest<SelectedJob>(entityName: "SelectedJob")
        request.predicate = NSPredicate(format: "id == %@", jobId)
        guard let jobs = try? viewContext.fetch(request) else { return }
        guard let job = jobs.first else { return }
        job.candidacy?.candidacyDate = candidacyDate ?? job.candidacy?.candidacyDate
        job.candidacy?.candidacyMeans = candidacyMeans ?? job.candidacy?.candidacyMeans
        job.candidacy?.comment = comment ?? job.candidacy?.comment
        job.candidacy?.state = state ?? job.candidacy?.state
        saveData()
    }
    
    func fetchAllCandidacies() -> [Candidacy] {
        let request = NSFetchRequest<Candidacy>(entityName: "Candidacy")
        guard let candidacies = try? viewContext.fetch(request) else { return [] }
        return candidacies
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
    
    // MARK: Contact
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
        let request = NSFetchRequest<Contact>(entityName: "Contact")
        request.predicate = NSPredicate(format: "id == %@", contactId as CVarArg)
        guard let contacts = try? viewContext.fetch(request) else { return }
        guard let contact = contacts.first else { return }
        viewContext.delete(contact)
        saveData()
    }
    
    func updateContact(contactId: UUID, name: String, compagny: String, functionInCompany: String, contactMail: String, contactPhoneNumber: String) {
        let request = NSFetchRequest<Contact>(entityName: "Contact")
        request.predicate = NSPredicate(format: "id == %@", contactId as CVarArg)
        guard let contacts = try? viewContext.fetch(request) else { return }
        guard let contact = contacts.first else { return }
        contact.name = name
        contact.compagny = compagny
        contact.functionInCompany = functionInCompany
        contact.email = contactMail
        contact.phoneNumber = contactPhoneNumber
        saveData()
    }
    
    func fetchContactWhoStartBy(name: String) -> [Contact]{
        let request = NSFetchRequest<Contact>(entityName: "Contact")
        request.predicate = NSPredicate(format: "name contains[c] %@", name)
        guard let contacts = try? viewContext.fetch(request) else { return [] }
        return contacts
    }
    
    func fetchContactByName(name: String) throws -> Contact?{
        let request = NSFetchRequest<Contact>(entityName: "Contact")
        request.predicate = NSPredicate(format: "name == %@", name)
        guard let contact = try? viewContext.fetch(request).first else { return nil }
        return contact
    }
    
    func fetchCandidacyContactsList(candidacyID: UUID) -> [Contact]{
        let request = NSFetchRequest<Candidacy>(entityName: "Candidacy")
        request.predicate = NSPredicate(format: "id == %@", candidacyID as CVarArg)
        guard let candidacies = try? viewContext.fetch(request) else { return [] }
        let candidacy = candidacies.first
        return candidacy?.contact?.allObjects as! [Contact]
    }
    
    func fetchAllCandidaciesOfContact(contactId: UUID) -> [Candidacy]{
        let request = NSFetchRequest<Contact>(entityName: "Contact")
        request.predicate = NSPredicate(format: "id == %@", contactId as CVarArg)
        guard let contacts = try?  viewContext.fetch(request) else { return []}
        let contact = contacts.first
        return contact?.candidacy?.allObjects as! [Candidacy]
    }
    
    // MARK: Relaunch
    func createRelaunch(candidacyID: UUID, contact: Contact?, date: Date, comment: String, means: String) {
        let request = NSFetchRequest<Candidacy>(entityName: "Candidacy")
        request.predicate = NSPredicate(format: "id == %@", candidacyID as CVarArg)
        guard let candidacies = try? viewContext.fetch(request) else { return }
        let candidacy = candidacies.first
        let relaunch = Relaunch(context: viewContext)
        relaunch.id = UUID()
        relaunch.contact = contact
        relaunch.date = date
        relaunch.comment = comment
        relaunch.means = means
        relaunch.candidacy = candidacy
        saveData()
    }
    
    func updateRelaunch(relaunchId: UUID, contact: Contact?, date: Date, comment: String, means: String) {
        let request = NSFetchRequest<Relaunch>(entityName: "Relaunch")
        request.predicate = NSPredicate(format: "id == %@", relaunchId as CVarArg)
        do {
            let relaunches = try! viewContext.fetch(request)
            guard let relaunch = relaunches.first else { return }
            relaunch.contact = contact
            relaunch.date = date
            relaunch.comment = comment
            relaunch.means = means
            saveData()
        }
    }
    
    func fetchAllRelaunchesfromCandidacyId(candidacyId: UUID, ascendingDate: Bool) -> [Relaunch] {
        let request = NSFetchRequest<Relaunch>(entityName: "Relaunch")
        request.predicate = NSPredicate(format: "candidacy.id == %@", candidacyId as CVarArg)
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Relaunch.date), ascending: ascendingDate)
        request.sortDescriptors = [sortDescriptor]
        guard let relaunches = try? viewContext.fetch(request) else { return [] }
        return relaunches
    }
    
    func removeRelaunch(relaunchId: UUID) {
        let request = NSFetchRequest<Relaunch>(entityName: "Relaunch")
        request.predicate = NSPredicate(format: "id == %@", relaunchId as CVarArg)
        guard let relaunches = try? viewContext.fetch(request) else { return }
        guard let relaunch = relaunches.first else { return }
        viewContext.delete(relaunch)
        saveData()
    }
    
    // MARK: Interview
    func createInterview(candidacyID: UUID, contact: Contact?, date: Date, comment: String) {
        let request = NSFetchRequest<Candidacy>(entityName: "Candidacy")
        request.predicate = NSPredicate(format: "id == %@", candidacyID as CVarArg)
        guard let candidacies = try? viewContext.fetch(request) else { return }
        let candidacy = candidacies.first
        let interview = Interview(context: viewContext)
        interview.id = UUID()
        interview.date = date
        interview.contact = contact
        interview.comment = comment
        interview.candidacy = candidacy
        saveData()
    }
    
    func updateInterview(interviewId: UUID, contact: Contact?, date: Date, comment: String) {
        let request = NSFetchRequest<Interview>(entityName: "Interview")
        request.predicate = NSPredicate(format: "id == %@", interviewId as CVarArg)
        do {
            let interview = try viewContext.fetch(request).first
            interview?.contact = contact
            interview?.date = date
            interview?.comment = comment
            saveData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchInterviewWithId(interviewId: UUID) -> Interview {
        let request = NSFetchRequest<Interview>(entityName: "Interview")
        request.predicate = NSPredicate(format: "id == %@", interviewId as CVarArg)
        let interview = try! viewContext.fetch(request).first
        return interview!
    }
    
    func fetchAllInterviews() -> [Interview] {
        let request = NSFetchRequest<Interview>(entityName: "Interview")
        guard let interviews = try?  viewContext.fetch(request) else { return [] }
        return interviews
    }
    
    func removeInterview(interviewId: UUID) {
        let request = NSFetchRequest<Interview>(entityName: "Interview")
        request.predicate = NSPredicate(format: "id == %@", interviewId as CVarArg)
        guard let interviews = try? viewContext.fetch(request) else { return }
        guard let interview = interviews.first else { return }
        viewContext.delete(interview)
        saveData()
    }
    
    // MARK: ActionsToBeTaken
    func fetchAllInterviewFromCandidacyId(candidacyId: UUID, ascendingDate: Bool) -> [Interview] {
        let request = NSFetchRequest<Interview>(entityName: "Interview")
        request.predicate = NSPredicate(format: "candidacy.id == %@", candidacyId as CVarArg)
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Interview.date), ascending: ascendingDate)
        request.sortDescriptors = [sortDescriptor]
        guard let interviews = try? viewContext.fetch(request) else { return [] }
        return interviews
    }
}

public extension NSManagedObject {
    // MARK: remove issue Multiple NSEntityDescriptions claim the NSManagedObject subclass
    // MARK: find on : https://github.com/drewmccormack/ensembles/issues/275
    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }
    
}
