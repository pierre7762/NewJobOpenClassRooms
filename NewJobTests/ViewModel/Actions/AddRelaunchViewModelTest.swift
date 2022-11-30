//
//  AddRelaunchViewModelTest.swift
//  NewJobTests
//
//  Created by Pierre on 30/11/2022.
//

import XCTest
@testable import NewJob

final class AddRelaunchViewModelTest: XCTestCase {
    var coreDataStack: FakeCoreDataStack!
    var pmTest: PersistenceManager!
    var vm: AddRelaunchViewModel!
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
    var candidacy: Candidacy!

    // MARK: - Tests Life Cycle
    override func setUp() {
        super.setUp()
        coreDataStack = FakeCoreDataStack()
        pmTest = PersistenceManager(coreDataStack: coreDataStack)
        vm = AddRelaunchViewModel()
        vm.pm = pmTest
        vm.pm.createSelectedJob(job: resultatJobTest)
        vm.pm.createCandidacy(candidacyMeans: "Mail", candidacyDate: Date.now, comment: "", favoriteJobId: "idString")
        candidacy = vm.pm.fetchAllCandidacies().first
    }
    
    override func tearDown() {
        super.tearDown()
        pmTest = nil
        coreDataStack = nil
        vm = nil
    }
    
    // MARK: - Tests
    func testFetchCandidacyContactList_WhenTwoContactSaved_thenReturnTwoContact() {
        vm.pm.createContact(jobId: "idString", name: "ContactName1", compagny: "Compagnye1", functionInCompany: "rh", contactMail: "mail", contactPhoneNumber: "0600000")
        vm.pm.createContact(jobId: "idString", name: "ContactName2", compagny: "Compagnye2", functionInCompany: "rh", contactMail: "mail2", contactPhoneNumber: "0600002")
        vm.fetchCandidacyContactList(candidacyId: candidacy.id!)
        XCTAssertEqual(vm.contactList.count, 2)
    }
    
    func testCreateRelaunch_WhenTwoContactSaved_thenReturnTwoContact() {
        let allRelaunch = vm.pm.fetchAllRelaunchesfromCandidacyId(candidacyId: candidacy.id!, ascendingDate: true)
        XCTAssertEqual(allRelaunch.count, 0)
        vm.pm.createContact(jobId: "idString", name: "ContactName1", compagny: "Compagnye1", functionInCompany: "rh", contactMail: "mail", contactPhoneNumber: "0600000")
        vm.contactSelected = "ContactName1"
        vm.createRelaunch(candidacyID: candidacy.id!)
        let allRelaunchAfter = vm.pm.fetchAllRelaunchesfromCandidacyId(candidacyId: candidacy.id!, ascendingDate: true)
        XCTAssertEqual(allRelaunchAfter.count, 1)
    }
}
