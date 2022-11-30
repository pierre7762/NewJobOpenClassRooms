//
//  ContactListViewModelTest.swift
//  NewJobTests
//
//  Created by Pierre on 29/11/2022.
//

import XCTest
@testable import NewJob

final class ContactListViewModelTest: XCTestCase {
    var coreDataStack: FakeCoreDataStack!
    var pmTest: PersistenceManager!
    var vm: ContactListViewModel!
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
        coreDataStack = FakeCoreDataStack()
        pmTest = PersistenceManager(coreDataStack: coreDataStack)
        vm = ContactListViewModel()
        vm.pm = pmTest
    }
    
    override func tearDown() {
        super.tearDown()
        pmTest = nil
        coreDataStack = nil
        vm = nil
    }
    
    // MARK: - Tests
    func testGetContactsList_WhenDBHaveOneContact_ThenShouldCreateContact() {
        vm.pm.createSelectedJob(job: resultatJobTest)
        vm.pm.createCandidacy(candidacyMeans: "", candidacyDate: Date.now, comment: "", favoriteJobId: "idString")
        vm.pm.createContact(jobId: "idString", name: "ContactName", compagny: "CompagnyName", functionInCompany: "RH", contactMail: "rh@test.fr", contactPhoneNumber: "06.00.00.00.00")
        let jobs = vm.pm.fetchSelectedJobs()
        let job = jobs.first
        let contactToThisJob = job!.candidacy?.contact?.count
        XCTAssertEqual(contactToThisJob, 1)
        
        vm.getContactsList()
        
        XCTAssertEqual(vm.contacts.count, 1)
    }
    
    func testDeleteContact_WhenDBHaveOneContact_ThenShouldReturnEmpty() {
        vm.pm.createSelectedJob(job: resultatJobTest)
        vm.pm.createCandidacy(candidacyMeans: "", candidacyDate: Date.now, comment: "", favoriteJobId: "idString")
        vm.pm.createContact(jobId: "idString", name: "ContactName", compagny: "CompagnyName", functionInCompany: "RH", contactMail: "rh@test.fr", contactPhoneNumber: "06.00.00.00.00")
        
        vm.getContactsList()
        XCTAssertEqual(vm.contacts.count, 1)
        
        vm.deleteContact(id: vm.contacts[0].id!)
        XCTAssertEqual(vm.contacts.count, 0)
    }


}
