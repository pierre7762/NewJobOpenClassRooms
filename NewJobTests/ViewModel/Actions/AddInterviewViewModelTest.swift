//
//  AddInterviewViewModelTest.swift
//  NewJobTests
//
//  Created by Pierre on 06/12/2022.
//

import XCTest
@testable import NewJob

final class AddInterviewViewModelTest: XCTestCase {
    var pmTest: PersistenceManager!
    var vm: AddInterviewViewModel!
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
        pmTest = PersistenceManager(inMemory: true)
        vm = AddInterviewViewModel()
        vm.pm = pmTest
        vm.pm.createSelectedJob(job: resultatJobTest)
        vm.pm.createCandidacy(candidacyMeans: "Mail", candidacyDate: Date.now, comment: "", favoriteJobId: "idString")
        candidacy = vm.pm.fetchAllCandidacies().first
    }

    override func tearDown() {
        super.tearDown()
        pmTest = nil
        vm = nil
    }

    // MARK: - Tests
    func testCreateInterview_WhenEmpty_thenReturnOneInterview() {
        vm.createInterview(candidacyId: candidacy.id!)
        let resultCreateInterview = vm.pm.fetchAllInterviewFromCandidacyId(candidacyId: candidacy.id!, ascendingDate: true)
        XCTAssertEqual(resultCreateInterview.count, 1)
    }
    
    func testCreateInterview_WhenContactIsSelected_thenReturnContactName() {
        vm.pm.createContact(jobId: resultatJobTest.id, name: "Paul", compagny: "Paul&Co", functionInCompany: "RH", contactMail: "", contactPhoneNumber: "")
        vm.fetchCandidacyContactList(candidacyId: candidacy.id!)
        vm.contactSelected = "Paul"
        
        vm.createInterview(candidacyId: candidacy.id!)
        let resultCreateInterview = vm.pm.fetchAllInterviewFromCandidacyId(candidacyId: candidacy.id!, ascendingDate: true)
        XCTAssertEqual(resultCreateInterview[0].contact?.name, "Paul")
    }
    
    func testRemoveInterview_WhenOneInterview_thenReturnZeroInterview() {
        vm.createInterview(candidacyId: candidacy.id!)
        let resultCreateInterview = vm.pm.fetchAllInterviewFromCandidacyId(candidacyId: candidacy.id!, ascendingDate: true)
        XCTAssertEqual(resultCreateInterview.count, 1)
        vm.removeInterview(interviewId: resultCreateInterview[0].id!)
        let resultRemoveInterview = vm.pm.fetchAllInterviewFromCandidacyId(candidacyId: candidacy.id!, ascendingDate: true)
        XCTAssertEqual(resultRemoveInterview.count, 0)
    }
    
    func testFetchCandidacyContactList_WhenOneContact_thenReturnOne() {
        vm.pm.createContact(jobId: resultatJobTest.id, name: "Paul", compagny: "Paul&Co", functionInCompany: "RH", contactMail: "", contactPhoneNumber: "")
        vm.fetchCandidacyContactList(candidacyId: candidacy.id!)
        
        XCTAssertEqual(vm.contactList.count, 1)
    }
}
