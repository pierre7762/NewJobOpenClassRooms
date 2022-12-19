//
//  AddInterviewViewModelTest.swift
//  NewJobTests
//
//  Created by Pierre on 06/12/2022.
//

import XCTest
@testable import NewJob

final class InterviewFormViewModelTest: XCTestCase {
    var pmTest: PersistenceManager!
    var vm: InterviewFormViewModel!
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
        vm = InterviewFormViewModel()
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
    
    func testInitInterviewForm_whenInterviewExist_thenUpdateData() {
        vm.createInterview(candidacyId: candidacy.id!)
        let resultCreateInterview = vm.pm.fetchAllInterviewFromCandidacyId(candidacyId: candidacy.id!, ascendingDate: true)
        XCTAssertEqual(resultCreateInterview.count, 1)
        let interviewTest = resultCreateInterview[0]
        interviewTest.comment = "it's upadte"
        XCTAssertEqual(vm.interviewComment, "")
        vm.initInterviewForm(candidacyId: candidacy.id!, interview: interviewTest)
        XCTAssertEqual(vm.interviewComment, "it's upadte")
    }
    
    func testGetContactOrNil_whenContactIsNonPrecise_thenReturnNil() {
        let result = vm.getContactOrNil()
        XCTAssertEqual(vm.contactSelected, "Non précisé")
        XCTAssertNil(result)
    }
    
    func testGetContactOrNil_whenContactIsSelected_thenReturnContact() {
        vm.pm.createContact(jobId: "idString", name: "ContactName1", compagny: "Compagnye1", functionInCompany: "rh", contactMail: "mail", contactPhoneNumber: "0600000")
        vm.fetchCandidacyContactList(candidacyId: candidacy.id!)
        XCTAssertEqual(vm.contactList.count, 1)
        vm.contactSelected = "ContactName1"
        let result = vm.getContactOrNil()
        XCTAssertEqual(result?.name, "ContactName1")
    }
    
    func testGetContactOrNil_whenContactFetchFailed_thenReturnContactIsNil() {
        vm.contactSelected = "ContactName1"
        let result = vm.getContactOrNil()
        XCTAssertNil(result)
    }
    
    func testUpdateInterview_whenInterviewExist_thenUpateInterview() {
        vm.createInterview(candidacyId: candidacy.id!)
        var resultCreateInterview = vm.pm.fetchAllInterviewFromCandidacyId(candidacyId: candidacy.id!, ascendingDate: true)
        XCTAssertEqual(resultCreateInterview.count, 1)
        var interviewTest = resultCreateInterview[0]
        XCTAssertEqual(interviewTest.comment, "")
        vm.interviewComment = "upadted"
        vm.updateInterview(interViewId: interviewTest.id!)
        resultCreateInterview = vm.pm.fetchAllInterviewFromCandidacyId(candidacyId: candidacy.id!, ascendingDate: true)
        interviewTest = resultCreateInterview[0]
        XCTAssertEqual(interviewTest.comment, "upadted")
    }
    
    func testActionToDo_whenwhenInterviewIsNil_thenCreateInterview() {
        var resultCreateInterview = vm.pm.fetchAllInterviewFromCandidacyId(candidacyId: candidacy.id!, ascendingDate: true)
        XCTAssertEqual(resultCreateInterview.count, 0)
        vm.actionToDo(candidacyID: candidacy.id, interviewId: nil)
        resultCreateInterview = vm.pm.fetchAllInterviewFromCandidacyId(candidacyId: candidacy.id!, ascendingDate: true)
        XCTAssertEqual(resultCreateInterview.count, 1)
    }
    
    func testActionToDo_whenwhenInterviewExist_thenUpateInterview() {
        vm.createInterview(candidacyId: candidacy.id!)
        var resultCreateInterview = vm.pm.fetchAllInterviewFromCandidacyId(candidacyId: candidacy.id!, ascendingDate: true)
        XCTAssertEqual(resultCreateInterview.count, 1)
        vm.actionToDo(candidacyID: candidacy.id, interviewId: resultCreateInterview[0].id)
        resultCreateInterview = vm.pm.fetchAllInterviewFromCandidacyId(candidacyId: candidacy.id!, ascendingDate: true)
        XCTAssertEqual(resultCreateInterview.count, 1)
    }
}
