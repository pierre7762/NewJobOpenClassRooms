//
//  PersistanceManagerTest.swift
//  NewJobTests
//
//  Created by Pierre on 28/11/2022.
//

import XCTest
import CoreData
@testable import NewJob

final class PersistanceManagerTest: XCTestCase {
    var pmTest: PersistenceManager!
    let resultatJobTest1 = Resultat(
        id: "idString",
        intitule: "JobCreationTest",
        resultatDescription:"",
        dateCreation: "",
        lieuTravail: LieuTravail(libelle: "placeOfJobTest", latitude: nil, longitude: nil, codepostal: "test", commune: "testTown"),
        entreprise: Entreprise(nom: "CompagnyTest", entrepriseDescription: nil, entrepriseAdaptee: true),
        appellationlibelle: nil,
        salaire: Salaire(libelle: "test", commentaire: nil, complement1: nil, complement2: nil),
        origineOffre: OrigineOffre(origine: "string origin", urlOrigine: "urlOrigine", partenaires: [Partenaire(nom: "partenaireNAme", url: "url", logo: "logo")])
    )
    let resultatJobTest2 = Resultat(
        id: "idString2",
        intitule: "JobCreationTest2",
        resultatDescription:"",
        dateCreation: "",
        lieuTravail: LieuTravail(libelle: "placeOfJobTest", latitude: nil, longitude: nil, codepostal: "test", commune: "testTown"),
        entreprise: Entreprise(nom: "CompagnyTest", entrepriseDescription: nil, entrepriseAdaptee: true),
        appellationlibelle: nil,
        salaire: Salaire(libelle: "test", commentaire: nil, complement1: nil, complement2: nil),
        origineOffre: OrigineOffre(origine: "string origin", urlOrigine: "urlOrigine", partenaires: [Partenaire(nom: "partenaireNAme", url: "url", logo: "logo")])
    )

    // MARK: - Tests Life Cycle
    override func setUp() {
        super.setUp()
        pmTest = PersistenceManager(inMemory: true)
    }

    override func tearDown() {
        super.tearDown()
        pmTest = nil
    }

    // MARK: - Tests

    func testFetchSelectedJobs_WhenDataBaseIsEmpty_ThenShouldReturnACountAtZero() {
        let data = pmTest.fetchSelectedJobs(onlyInProgress: false)
        let expectedCount = 0
        let count = data.count

        XCTAssertEqual(count, expectedCount)
    }

    func testCreateSelectedJob_WhenDataBaseIsEmpty_ThenShouldReturnACountAtZero() {
        let initialData = pmTest.fetchSelectedJobs(onlyInProgress: false)
        pmTest.createSelectedJob(job: resultatJobTest1)
        let dataAfterAdding = pmTest.fetchSelectedJobs(onlyInProgress: false)
        let expectationCountBeforeAdding = 0
        let expectationCountAfterAdding = 1

        XCTAssertEqual(initialData.count, expectationCountBeforeAdding)
        XCTAssertEqual(dataAfterAdding.count, expectationCountAfterAdding)
    }

    func testRemoveSelectedJob_WhenDataBaseHadTwoJob_ThenShouldStayOne() {
        pmTest.createSelectedJob(job: resultatJobTest1)
        pmTest.createSelectedJob(job: resultatJobTest2)
        let dataAfterAdding = pmTest.fetchSelectedJobs(onlyInProgress: false)
        XCTAssertEqual(dataAfterAdding.count, 2)

        pmTest.removeSelectedJob(selectedJobId: resultatJobTest1.id)
        let dataAfterRemoving = pmTest.fetchSelectedJobs(onlyInProgress: false)
        XCTAssertEqual(dataAfterRemoving.count, 1)
        XCTAssertEqual(dataAfterRemoving[0].entitled, "JobCreationTest2")
    }

    func testGetSelectedJobWithId_WhenOneJobIsCreate_ThenShouldReturnTheGoodJob() {
        let initialData = pmTest.fetchSelectedJobs(onlyInProgress: false)
        pmTest.createSelectedJob(job: resultatJobTest1)
        pmTest.createSelectedJob(job: resultatJobTest2)
        let dataAfterAdding = pmTest.fetchSelectedJobs(onlyInProgress: false)
        let expectationCountBeforeAdding = 0
        let expectationCountAfterAdding = 2
        let expectationJobEntitled = "JobCreationTest2"
        let jobResult = try? pmTest.getSelectedJobWithId(id: "idString2")

        XCTAssertEqual(initialData.count, expectationCountBeforeAdding)
        XCTAssertEqual(dataAfterAdding.count, expectationCountAfterAdding)
        XCTAssertEqual(expectationJobEntitled, jobResult!.entitled)
    }
    
    func testFetchSelectedJobsWhithoutCandidacy_WhenOneJobWithCandidacyAndOneWithout_ThenReturnOne() {
        let initialResult = pmTest.fetchSelectedJobsWhithoutCandidacy()
        XCTAssertEqual(initialResult.count, 0)
        pmTest.createSelectedJob(job: resultatJobTest1)
        pmTest.createSelectedJob(job: resultatJobTest2)
        pmTest.createCandidacy(candidacyMeans: "Mail", candidacyDate: Date.now, comment: "", favoriteJobId: "idString2")
        
        let expectation = 1
        let result = pmTest.fetchSelectedJobsWhithoutCandidacy()
        XCTAssertEqual(expectation, result.count)
        XCTAssertEqual(result[0].id, "idString")
    }
    
    func testFetchSelectedJobsWithCandidacy_WhenOneJobWithCandidacyAndOneWithout_ThenReturnOne() {
        let initialResult = pmTest.fetchSelectedJobsWithCandidacy()
        XCTAssertEqual(initialResult.count, 0)
        pmTest.createSelectedJob(job: resultatJobTest1)
        pmTest.createSelectedJob(job: resultatJobTest2)
        pmTest.createCandidacy(candidacyMeans: "Mail", candidacyDate: Date.now, comment: "", favoriteJobId: "idString2")
        
        let expectation = 1
        let result = pmTest.fetchSelectedJobsWithCandidacy()
        XCTAssertEqual(expectation, result.count)
        XCTAssertEqual(result[0].id, "idString2")
    }
    
    func testFetchSelectedJobsByState_WhenTwoJobsWithReject_ThenReturnOne() {
        let initialResult = pmTest.fetchSelectedJobsByState(candidacyState: "Validée")
        XCTAssertEqual(initialResult.count, 0)
        pmTest.createSelectedJob(job: resultatJobTest1)
        pmTest.createSelectedJob(job: resultatJobTest2)
        pmTest.createCandidacy(candidacyMeans: "Mail", candidacyDate: Date.now, comment: "", favoriteJobId: "idString")
        pmTest.createCandidacy(candidacyMeans: "Mail", candidacyDate: Date.now, comment: "", favoriteJobId: "idString2")
        pmTest.updateSelectedJobCandidacy(jobId: "idString2", candidacyDate: nil, candidacyMeans: nil, comment: nil, state: "Validée")
        let expectation = 1
        let result = pmTest.fetchSelectedJobsByState(candidacyState: "Validée")
        XCTAssertEqual(expectation, result.count)
        XCTAssertEqual(result[0].id, "idString2")
    }

    //    func testGetSelectedJobWithId_WhenGiveWrongId_ThenShouldReturnError() {
    //        let initialData = persistenceManagerTest.fetchSelectedJobs()
    //        persistenceManagerTest.createSelectedJob(job: resultatJobTest1)
    //        let expectationJobEntitled = "JobCreationTest2"
    //        let jobResult = try? persistenceManagerTest.getSelectedJobWithId(id: "idString1")
    //
    //        XCTAssertEqual(expectationJobEntitled, "")
    //    }

    func testCheckIfIsFavoriteResultat_WhenTheResultIsAdded_ThenShouldReturnTrue() {
        pmTest.createSelectedJob(job: resultatJobTest1)
        pmTest.createSelectedJob(job: resultatJobTest2)
        let jobResult = pmTest.checkIfIsFavoriteResultat(job: resultatJobTest2)

        XCTAssertTrue(jobResult)
    }

    func testCheckIfIsFavoriteResultat_WhenTheJobIsCreate_ThenShouldReturnTrue() {
        pmTest.createSelectedJob(job: resultatJobTest1)
        let selectedJobsList = pmTest.fetchSelectedJobs(onlyInProgress: false)
        let job = selectedJobsList.first

        let jobResult = pmTest.checkIfIsFavoriteSelectedJob(job: job!)
        XCTAssertEqual(jobResult, true)
    }

    // MARK: Candidacy
    func testCreateCandidacy_WhenDataAreOk_ThenShouldAddCandidacy() {
        let initialData = pmTest.fetchSelectedJobs(onlyInProgress: false)
        pmTest.createSelectedJob(job: resultatJobTest1)
        let dataAfterAddJob = pmTest.fetchSelectedJobs(onlyInProgress: false)
        XCTAssertEqual(initialData.count, 0)
        XCTAssertEqual(dataAfterAddJob.count, 1)

        pmTest.createCandidacy(candidacyMeans: "mail", candidacyDate: Date.now, comment: "test comment", favoriteJobId: "idString")
        let jobs = pmTest.fetchSelectedJobs(onlyInProgress: false)
        let candidacy = jobs.first?.candidacy

        XCTAssertEqual(candidacy?.comment, "test comment")
    }

    func testRemoveCandidacy_WhenSendJobId_ThenShouldRemovecandidacy() {
        pmTest.createSelectedJob(job: resultatJobTest1)
        pmTest.createCandidacy(candidacyMeans: "mail", candidacyDate: Date.now, comment: "test comment", favoriteJobId: "idString")
        let jobs = pmTest.fetchSelectedJobs(onlyInProgress: false)

        XCTAssertEqual(jobs.first?.candidacy?.comment, "test comment")
        pmTest.removeCandidacy(favoriteJobId: "idString")
        let jobs2 = pmTest.fetchSelectedJobs(onlyInProgress: false)
        XCTAssertEqual(jobs2.first?.candidacy, nil)
    }

    func testRemoveCandidacy_WhenSendWrongJobId_ThenShouldReturnError() {
        pmTest.createSelectedJob(job: resultatJobTest1)
        pmTest.createCandidacy(candidacyMeans: "mail", candidacyDate: Date.now, comment: "test comment", favoriteJobId: "idString")
        let jobs = pmTest.fetchSelectedJobs(onlyInProgress: false)

        XCTAssertEqual(jobs.first?.candidacy?.comment, "test comment")
        pmTest.removeCandidacy(favoriteJobId: "idStrin")
        let jobs2 = pmTest.fetchSelectedJobs(onlyInProgress: false)
        XCTAssertEqual(jobs2.first?.candidacy?.comment, "test comment")
    }

    func testUpdateSelectedJobCandidacy_WhenSendCandidacyUpdated_ThenShouldUpdateCandidacy() {
        pmTest.createSelectedJob(job: resultatJobTest1)
        pmTest.createCandidacy(candidacyMeans: "mail", candidacyDate: Date.now, comment: "test comment", favoriteJobId: "idString")
        let jobs = pmTest.fetchSelectedJobs(onlyInProgress: false)
        XCTAssertEqual(jobs.first?.candidacy?.comment, "test comment")

        pmTest.updateSelectedJobCandidacy(
            jobId: "idString",
            candidacyDate: nil,
            candidacyMeans: nil,
            comment: nil,
            state: nil)
        pmTest.updateSelectedJobCandidacy(
            jobId: "idString",
            candidacyDate: nil,
            candidacyMeans: "Non précisé",
            comment: "comment Updated",
            state: nil)
        let jobs2 = pmTest.fetchSelectedJobs(onlyInProgress: false)
        XCTAssertEqual(jobs2.first?.candidacy?.comment, "comment Updated")
        XCTAssertEqual(jobs2.first?.candidacy?.candidacyMeans, "Non précisé")
    }

    func testFetchAllCandidacies_WhenDataBaseHaveTwoCandidacy_ThenReturnTwo() {
        let initialCandidaciesList = pmTest.fetchAllCandidacies()
        XCTAssertEqual(initialCandidaciesList.count, 0)
        pmTest.createSelectedJob(job: resultatJobTest1)
        pmTest.createCandidacy(candidacyMeans: "mail", candidacyDate: Date.now, comment: "test comment", favoriteJobId: "idString")
        pmTest.createSelectedJob(job: resultatJobTest2)
        pmTest.createCandidacy(candidacyMeans: "Non précisé", candidacyDate: Date.now, comment: "test comment 2", favoriteJobId: "idString2")
        let allCandidacies = pmTest.fetchAllCandidacies()

        XCTAssertEqual(allCandidacies.count, 2)
    }

    func testFetchSelectedJobWhoHaveCandidacyMake_WhenDataBaseHaveOneJobWithCandidacy_ThenReturnOneJob() {
        let initialCandidaciesList = pmTest.fetchAllCandidacies()
        XCTAssertEqual(initialCandidaciesList.count, 0)
        pmTest.createSelectedJob(job: resultatJobTest1)
        pmTest.createCandidacy(candidacyMeans: "mail", candidacyDate: Date.now, comment: "test comment", favoriteJobId: "idString")
        pmTest.createSelectedJob(job: resultatJobTest2)
        let jobs = pmTest.fetchSelectedJobs(onlyInProgress: false)

        let allJobsWithCandidacy = pmTest.fetchSelectedJobWhoHaveCandidacyMake(jobs: jobs)

        XCTAssertEqual(allJobsWithCandidacy.count, 1)
    }

    func testFetchCandidacyContactsList_WhenCandidacyHaveTwoContact_ThenShouldReturnTwoContact() {
        pmTest.createSelectedJob(job: resultatJobTest1)
        pmTest.createCandidacy(candidacyMeans: "mail", candidacyDate: Date.now, comment: "test comment", favoriteJobId: "idString")
        pmTest.createContact(jobId: "idString", name: "ContactName", compagny: "CompagnyName", functionInCompany: "RH", contactMail: "rh@test.fr", contactPhoneNumber: "06.00.00.00.00")
        pmTest.createContact(jobId: "idString", name: "ContactName2", compagny: "CompagnyName2", functionInCompany: "RH2", contactMail: "rh@test.com", contactPhoneNumber: "06.00.00.00.01")
        let allCandidacy = pmTest.fetchAllCandidacies()
        let candidacy = allCandidacy[0]
        let allContactFromCandidacy = pmTest.fetchCandidacyContactsList(candidacyID: candidacy.id!)

        XCTAssertEqual(allContactFromCandidacy.count, 2)
    }

    // MARK: Contact
    func testCreateContact_WhenPassJobId_ThenShouldCreateContact() {
        pmTest.createSelectedJob(job: resultatJobTest1)
        pmTest.createCandidacy(candidacyMeans: "", candidacyDate: Date.now, comment: "", favoriteJobId: "idString")
        pmTest.createContact(jobId: "idString", name: "ContactName", compagny: "CompagnyName", functionInCompany: "RH", contactMail: "rh@test.fr", contactPhoneNumber: "06.00.00.00.00")
        let jobs = pmTest.fetchSelectedJobs(onlyInProgress: false)
        let job = jobs.first
        let contactToThisJob = job!.candidacy?.contact?.count

        XCTAssertEqual(contactToThisJob, 1)
    }

    func testFetchAllContacts_WhenDataBaseHadTwoContacts_ThenShouldReturnTwo() {
        pmTest.createSelectedJob(job: resultatJobTest1)
        pmTest.createSelectedJob(job: resultatJobTest2)
        pmTest.createCandidacy(candidacyMeans: "", candidacyDate: Date.now, comment: "", favoriteJobId: "idString")
        pmTest.createCandidacy(candidacyMeans: "", candidacyDate: Date.now, comment: "", favoriteJobId: "idString2")
        pmTest.createContact(jobId: "idString2", name: "ContactName2", compagny: "CompagnyName", functionInCompany: "RH", contactMail: "rh@test.fr", contactPhoneNumber: "06.00.00.00.00")
        pmTest.createContact(jobId: "idString", name: "ContactName", compagny: "CompagnyName", functionInCompany: "RH", contactMail: "rh@test.fr", contactPhoneNumber: "06.00.00.00.00")
        let contacts = pmTest.fetchContact()

        XCTAssertEqual(contacts.count, 2)
    }

    func testFetchContactById_WhenDataBaseHadTwoContacts_ThenShouldReturnTheGoodContact() {
        pmTest.createSelectedJob(job: resultatJobTest1)
        pmTest.createSelectedJob(job: resultatJobTest2)
        pmTest.createCandidacy(candidacyMeans: "", candidacyDate: Date.now, comment: "", favoriteJobId: "idString")
        pmTest.createCandidacy(candidacyMeans: "", candidacyDate: Date.now, comment: "", favoriteJobId: "idString2")
        pmTest.createContact(jobId: "idString2", name: "ContactName2", compagny: "CompagnyName", functionInCompany: "RH", contactMail: "rh@test.fr", contactPhoneNumber: "06.00.00.00.00")
        pmTest.createContact(jobId: "idString", name: "ContactName", compagny: "CompagnyName", functionInCompany: "RH", contactMail: "rh@test.fr", contactPhoneNumber: "06.00.00.00.00")
        let contacts = pmTest.fetchContact()
        let contact = contacts[0]
        let contactGetWithFetchRequest = try? pmTest.fetchContactById(contactId: contact.id!)

        XCTAssertEqual(contact.name, contactGetWithFetchRequest!.name)
    }
    
    func testUpdateContact_whenContactNameChangeFromTestToUpdate_thenReturnUpdate() {
        pmTest.createSelectedJob(job: resultatJobTest1)
        pmTest.createCandidacy(candidacyMeans: "Mail", candidacyDate: Date.now, comment: "", favoriteJobId: resultatJobTest1.id)
        pmTest.createContact(jobId: "idString", name: "test", compagny: "", functionInCompany: "", contactMail: "", contactPhoneNumber: "")
        let contact = try? pmTest.fetchContactByName(name: "test")
        XCTAssertEqual(contact!.name, "test")
        pmTest.updateContact(contactId: contact!.id!, name: "update", compagny: "", functionInCompany: "", contactMail: "", contactPhoneNumber: "")
        let contactAfterUpdate = try? pmTest.fetchContactById(contactId: contact!.id!)
        XCTAssertEqual(contactAfterUpdate!.name, "update")
    }

    func testRemoveContact_WhenDataBaseHadTwoContacts_ThenShouldStayTheOtherContact() {
        pmTest.createSelectedJob(job: resultatJobTest1)
        pmTest.createCandidacy(candidacyMeans: "", candidacyDate: Date.now, comment: "", favoriteJobId: "idString")
        pmTest.createContact(jobId: "idString", name: "ContactName2", compagny: "CompagnyName", functionInCompany: "RH", contactMail: "rh@test.fr", contactPhoneNumber: "06.00.00.00.00")
        pmTest.createContact(jobId: "idString", name: "ContactName", compagny: "CompagnyName", functionInCompany: "RH", contactMail: "rh@test.fr", contactPhoneNumber: "06.00.00.00.00")
        let contacts = pmTest.fetchContact()
        let contact = contacts[0]
        let contactWhoMustStayAfterRemove = contacts[1]
        pmTest.removeContact(contactId: contact.id!)

        let contactsAfterRemove = pmTest.fetchContact()

        XCTAssertEqual(contactWhoMustStayAfterRemove.name, contactsAfterRemove[0].name)
    }

    func testFetchContactWhoStartBy_WhenDataBaseHadTwoContacts_ThenShouldReturnTwoContacts() {
        pmTest.createSelectedJob(job: resultatJobTest1)
        pmTest.createCandidacy(candidacyMeans: "", candidacyDate: Date.now, comment: "", favoriteJobId: "idString")
        pmTest.createContact(jobId: "idString", name: "ContactName2", compagny: "CompagnyName", functionInCompany: "RH", contactMail: "rh@test.fr", contactPhoneNumber: "06.00.00.00.00")
        pmTest.createContact(jobId: "idString", name: "ContactName", compagny: "CompagnyName", functionInCompany: "RH", contactMail: "rh@test.fr", contactPhoneNumber: "06.00.00.00.00")
        let contactsWhoStartByNameContactName = pmTest.fetchContactWhoStartBy(name: "Conta")

        XCTAssertEqual(contactsWhoStartByNameContactName.count, 2)
    }

    func testFetchContactByName_WhenDataBaseHadTwoContacts_ThenShouldTheGoodContact() {
        pmTest.createSelectedJob(job: resultatJobTest1)
        pmTest.createCandidacy(candidacyMeans: "", candidacyDate: Date.now, comment: "", favoriteJobId: "idString")
        pmTest.createContact(jobId: "idString", name: "ContactName2", compagny: "CompagnyName", functionInCompany: "RH", contactMail: "rh@test.fr", contactPhoneNumber: "06.00.00.00.00")
        pmTest.createContact(jobId: "idString", name: "ContactName", compagny: "CompagnyName", functionInCompany: "RH", contactMail: "rh@test.fr", contactPhoneNumber: "06.00.00.00.00")
        let contactWhoWithNameIsContactName = try? pmTest.fetchContactByName(name: "ContactName")

        XCTAssertEqual(contactWhoWithNameIsContactName!.name, "ContactName")
    }

    func testFetchAllCandidaciesOfContact_WhenDataBaseHaveTwoContacts_ThenShouldReturnOneCandidacy() {
        pmTest.createSelectedJob(job: resultatJobTest1)
        pmTest.createCandidacy(candidacyMeans: "", candidacyDate: Date.now, comment: "", favoriteJobId: "idString")
        pmTest.createContact(jobId: "idString", name: "ContactName2", compagny: "CompagnyName", functionInCompany: "RH", contactMail: "rh@test.fr", contactPhoneNumber: "06.00.00.00.00")
        pmTest.createContact(jobId: "idString", name: "ContactName", compagny: "CompagnyName", functionInCompany: "RH", contactMail: "rh@test.fr", contactPhoneNumber: "06.00.00.00.00")
        let contactWhoWithNameIsContactName = try? pmTest.fetchContactByName(name: "ContactName")
        let candidacies = pmTest.fetchAllCandidaciesOfContact(contactId: (contactWhoWithNameIsContactName?.id)!)

        XCTAssertEqual(candidacies.count, 1)
    }

    //MARK: Relaunch
    func testCreateRelaunch_WhenDataBaseHaveOneCandidacy_ThenShouldReturnOneRelaunch() {
        pmTest.createSelectedJob(job: resultatJobTest1)
        pmTest.createCandidacy(candidacyMeans: "", candidacyDate: Date.now, comment: "", favoriteJobId: "idString")
        let selectedJob = pmTest.fetchSelectedJobs(onlyInProgress: false).first
        let relaunches = pmTest.fetchAllRelaunchesfromCandidacyId(candidacyId: (selectedJob?.candidacy?.id)!, ascendingDate: true)
        XCTAssertEqual(relaunches.count, 0)

        pmTest.createRelaunch(candidacyID: (selectedJob?.candidacy?.id)!, contact: nil, date: Date.now, comment: "comment test", means: "Mail")
        let relaunchesAfterAdding = pmTest.fetchAllRelaunchesfromCandidacyId(candidacyId: (selectedJob?.candidacy?.id)!, ascendingDate: true)
        XCTAssertEqual(relaunchesAfterAdding.count, 1)
    }

    func testRemoveRelaunch_WhenDataBaseHaveOneRelaunch_ThenShouldReturnZero() {
        pmTest.createSelectedJob(job: resultatJobTest1)
        pmTest.createCandidacy(candidacyMeans: "", candidacyDate: Date.now, comment: "", favoriteJobId: "idString")
        let selectedJob = pmTest.fetchSelectedJobs(onlyInProgress: false).first
        pmTest.createRelaunch(candidacyID: (selectedJob?.candidacy?.id)!, contact: nil, date: Date.now, comment: "comment test", means: "Mail")
        let relaunches = pmTest.fetchAllRelaunchesfromCandidacyId(candidacyId: (selectedJob?.candidacy?.id)!, ascendingDate: true)
        XCTAssertEqual(relaunches.count, 1)

        pmTest.removeRelaunch(relaunchId: relaunches[0].id!)
        let relaunchesAfterRemove = pmTest.fetchAllRelaunchesfromCandidacyId(candidacyId: (selectedJob?.candidacy?.id)!, ascendingDate: true)
        XCTAssertEqual(relaunchesAfterRemove.count, 0)
    }

    // MARK: Interview
    func testCreateInterview_WhenDataBaseHaveZeroInterview_ThenShouldReturnOne() {
        pmTest.createSelectedJob(job: resultatJobTest1)
        pmTest.createCandidacy(candidacyMeans: "", candidacyDate: Date.now, comment: "", favoriteJobId: "idString")
        let selectedJob = pmTest.fetchSelectedJobs(onlyInProgress: false).first
        XCTAssertEqual(selectedJob?.candidacy?.relaunch?.count, 0)
        pmTest.createInterview(candidacyID: (selectedJob?.candidacy?.id)!, contact: nil, date: Date.now, comment: "Relaunch comment")
        let selectedJob2 = pmTest.fetchSelectedJobs(onlyInProgress: false).first
        XCTAssertEqual(selectedJob2?.candidacy?.relaunch?.count, 0)
    }
    
    func testUpadteInterview_whenEditInterview_thenUpdateInterview() {
        pmTest.createSelectedJob(job: resultatJobTest1)
        pmTest.createCandidacy(candidacyMeans: "", candidacyDate: Date.now, comment: "", favoriteJobId: "idString")
        let selectedJob = pmTest.fetchSelectedJobs(onlyInProgress: false).first
        XCTAssertEqual(selectedJob?.candidacy?.relaunch?.count, 0)
        pmTest.createInterview(candidacyID: (selectedJob?.candidacy?.id)!, contact: nil, date: Date.now, comment: "Interview comment")
        let allInterviews = pmTest.fetchAllInterviews()
        var interview = allInterviews.first
        XCTAssertEqual(interview?.comment, "Interview comment")
        pmTest.updateInterview(interviewId: (interview?.id!)!, contact: nil, date: (interview?.date)!, comment: "Interview updated")
        interview = allInterviews.first
        XCTAssertEqual(interview?.comment, "Interview updated")
    }
    
    func testFetchInterviewWithId_whenInterviewExist_thenReturnInterview() {
        pmTest.createSelectedJob(job: resultatJobTest1)
        pmTest.createCandidacy(candidacyMeans: "", candidacyDate: Date.now, comment: "", favoriteJobId: "idString")
        let selectedJob = pmTest.fetchSelectedJobs(onlyInProgress: false).first
        pmTest.createInterview(candidacyID: (selectedJob?.candidacy?.id)!, contact: nil, date: Date.now, comment: "Interview comment test ")
        let allInterviews = pmTest.fetchAllInterviews()
        guard let interviewId = allInterviews.first?.id else { return }
        let interviewGetWithFetch = pmTest.fetchInterviewWithId(interviewId: interviewId)
        XCTAssertEqual(interviewGetWithFetch.comment, "Interview comment test ")
        
        
    }

    func testFetchAllInterviews_WhenDataBaseHaveZeroInterview_ThenShouldReturnOne() {
        pmTest.createSelectedJob(job: resultatJobTest1)
        pmTest.createCandidacy(candidacyMeans: "", candidacyDate: Date.now, comment: "", favoriteJobId: "idString")
        let selectedJob = pmTest.fetchSelectedJobs(onlyInProgress: false).first
        pmTest.createInterview(candidacyID: (selectedJob?.candidacy?.id)!, contact: nil, date: Date.now, comment: "Relaunch comment")
        let allInterviews = pmTest.fetchAllInterviews()

        XCTAssertEqual(allInterviews.count, 1)
    }

    func testRemoveInterview_WhenDataBaseHaveOneInterview_ThenShouldReturnZero() {
        pmTest.createSelectedJob(job: resultatJobTest1)
        pmTest.createCandidacy(candidacyMeans: "", candidacyDate: Date.now, comment: "", favoriteJobId: "idString")
        let selectedJob = pmTest.fetchSelectedJobs(onlyInProgress: false).first
        pmTest.createInterview(candidacyID: (selectedJob?.candidacy?.id)!, contact: nil, date: Date.now, comment: "Relaunch comment")
        let allInterviews = pmTest.fetchAllInterviews()
        XCTAssertEqual(allInterviews.count, 1)
        pmTest.removeInterview(interviewId: allInterviews[0].id!)
        let allInterviews2 = pmTest.fetchAllInterviews()
        XCTAssertEqual(allInterviews2.count, 0)
    }
}
