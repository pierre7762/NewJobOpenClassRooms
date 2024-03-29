//
//  HomeViewModelTest.swift
//  NewJobTests
//
//  Created by Pierre on 30/11/2022.
//

import XCTest
@testable import NewJob

final class HomeViewModelTest: XCTestCase {
    var pmTest: PersistenceManager!
    var vm: HomeViewModel!
    let resultatJobTest = Resultat(
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

    // MARK: - Tests Life Cycle
    override func setUp() {
        super.setUp()
        pmTest = PersistenceManager(inMemory: true)
        vm = HomeViewModel()
        vm.pm = pmTest
        vm.pm.createSelectedJob(job: resultatJobTest)
        vm.pm.createCandidacy(candidacyMeans: "Mail", candidacyDate: Date.now, comment: "Comment", favoriteJobId: "idString")
        vm.pm.createContact(jobId: "idString", name: "Dupont", compagny: "Dupont&Co", functionInCompany: "CIO", contactMail: "dupont@dupont&co.fr", contactPhoneNumber: "0600000000")
    }
    
    override func tearDown() {
        super.tearDown()
        pmTest = nil
        vm = nil
    }
    
    // MARK: - Tests
    func testGetJobs_whenOneJobSave_thenReturnOneJob() {
        vm.getJobs()
        XCTAssertEqual(vm.jobs.count, 1)
    }
    
    func testGetJobsCount_whenOneJobSave_thenReturnOneJob() {
        vm.getJobs()
        vm.getJobsCount()
        XCTAssertEqual(vm.jobsCount, 1)
    }
    
    func testGetContacts_whenOneContactSave_thenReturnOneContact() {
        vm.getContacts()
        XCTAssertEqual(vm.contacts.count, 1)
    }
    
    func testUpdateData_whenOneJobAndOneContactSave_thenReturnOneJobAndOneContact() {
        XCTAssertEqual(vm.jobs.count, 0)
        XCTAssertEqual(vm.jobsCount, 0)
        XCTAssertEqual(vm.contacts.count, 0)
        vm.updateData()
        XCTAssertEqual(vm.jobs.count, 1)
        XCTAssertEqual(vm.jobsCount, 1)
        XCTAssertEqual(vm.contacts.count, 1)
    }
}
