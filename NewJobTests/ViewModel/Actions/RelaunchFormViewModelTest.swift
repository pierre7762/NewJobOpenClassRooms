//
//  AddRelaunchViewModelTest.swift
//  NewJobTests
//
//  Created by Pierre on 30/11/2022.
//

import XCTest
@testable import NewJob

final class RelaunchFormViewModelTest: XCTestCase {
    var pmTest: PersistenceManager!
    var vm: RelaunchFormViewModel!
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
        vm = RelaunchFormViewModel()
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
    func testInitRelaunch_whenCurrentRelaunchIsNil_thenDoNOthing(){
        XCTAssertEqual(vm.means, "Non précisé")
        vm.initRelaunch(currentRelaunch: nil)
        XCTAssertEqual(vm.means, "Non précisé")
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
    
    func testInitRelaunch_whenCurrentRelaunch_thenUpdateData(){
        vm.means = "Mail"
        vm.createRelaunch(candidacyID: candidacy.id!)
        vm.means = "Non précisé"
        XCTAssertEqual(vm.means, "Non précisé")
        let allRelaunchAfter = vm.pm.fetchAllRelaunchesfromCandidacyId(candidacyId: candidacy.id!, ascendingDate: true)
        XCTAssertEqual(allRelaunchAfter.count, 1)
        vm.initRelaunch(currentRelaunch: allRelaunchAfter.first)
        XCTAssertEqual(vm.means, "Mail")
    }
    
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
    
    func testUpdateRelaunch_whenUpdate_thenMakeUpdate(){
        vm.means = "Mail"
        vm.comment = "test"
        vm.createRelaunch(candidacyID: candidacy.id!)
        vm.means = "Non précisé"
        vm.comment = ""
        XCTAssertEqual(vm.means, "Non précisé")
        XCTAssertEqual(vm.comment, "")
        let currentRelaunchBeforeUpdate = vm.pm.fetchAllRelaunchesfromCandidacyId(candidacyId: candidacy.id!, ascendingDate: true).first
        XCTAssertEqual(currentRelaunchBeforeUpdate?.means, "Mail")
        XCTAssertEqual(currentRelaunchBeforeUpdate?.comment, "test")
        vm.means = "Site web"
        vm.comment = "test updated"
        vm.updateRelaunch(relaunchId: (currentRelaunchBeforeUpdate?.id!)!)
        let currentRelaunchAfterUpdate = vm.pm.fetchAllRelaunchesfromCandidacyId(candidacyId: candidacy.id!, ascendingDate: true).first
        XCTAssertEqual(currentRelaunchAfterUpdate?.means, "Site web")
        XCTAssertEqual(currentRelaunchAfterUpdate?.comment, "test updated")
    }
    
    func testActionToDo_WhenRelaunchCountIsZero_thenCreateRelaunch() {
        let resultBeforeAction = vm.pm.fetchAllRelaunchesfromCandidacyId(candidacyId: candidacy.id!, ascendingDate: true)
        XCTAssertEqual(resultBeforeAction.count, 0)
        vm.comment = "create relaunch ok"
        vm.actionToDo(candidacyID: candidacy.id!, relaunchId: nil)
        let resultAfterAction = vm.pm.fetchAllRelaunchesfromCandidacyId(candidacyId: candidacy.id!, ascendingDate: true)
        XCTAssertEqual(resultAfterAction.count, 1)
        XCTAssertEqual(resultAfterAction.first?.comment, "create relaunch ok")
    }
    
    func testActionToDo_WhenRelaunch_thenUpdateRelaunch() {
        vm.pm.createRelaunch(candidacyID: candidacy.id!, contact: nil, date: Date.now, comment: "before update", means: "Mail")
        let resultBeforeAction = vm.pm.fetchAllRelaunchesfromCandidacyId(candidacyId: candidacy.id!, ascendingDate: true)
        XCTAssertEqual(resultBeforeAction.count, 1)
        vm.comment = "update relaunch ok"
        vm.actionToDo(candidacyID: candidacy.id!, relaunchId: resultBeforeAction.first?.id)
        let resultAfterAction = vm.pm.fetchAllRelaunchesfromCandidacyId(candidacyId: candidacy.id!, ascendingDate: true)
        XCTAssertEqual(resultAfterAction.count, 1)
        XCTAssertEqual(resultAfterAction.first?.comment, "update relaunch ok")
    }
}
