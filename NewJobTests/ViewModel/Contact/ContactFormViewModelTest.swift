//
//  AddContactViewModelTest.swift
//  NewJobTests
//
//  Created by Pierre on 30/11/2022.
//

import XCTest
@testable import NewJob

final class ContactFormViewModelTest: XCTestCase {
    var pmTest: PersistenceManager!
    var vm: ContactFormViewModel!
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
    var job: SelectedJob!

    // MARK: - Tests Life Cycle
    override func setUp() {
        super.setUp()
        pmTest = PersistenceManager(inMemory: true)
        vm = ContactFormViewModel()
        vm.pm = pmTest
        vm.pm.createSelectedJob(job: resultatJobTest)
        vm.pm.createCandidacy(candidacyMeans: "Mail", candidacyDate: Date.now, comment: "", favoriteJobId: "idString")
        job = vm.pm.fetchSelectedJobs(onlyInProgress: true).first
    }
    
    override func tearDown() {
        super.tearDown()
        pmTest = nil
        vm = nil
    }
    
     //MARK: - Tests
    func testInitFavoriteJob_WhenInit_thenUpdateDatas() {
        vm.contactName = "TestName"
        vm.jobId = "idString"
        vm.createContact()
        let contactList = vm.pm.fetchContact()
        XCTAssertEqual(contactList.count, 1)
        XCTAssertEqual(contactList[0].name, vm.contactName)
        vm.contactName = ""
        XCTAssertEqual(vm.contactName, "")
        vm.initContact(actualContact: ContactDisplayable(contact: contactList[0], contactId: contactList[0].id!))
        XCTAssertEqual(vm.contactName, "TestName")
    }
    
    func testCreateContact_WhenNoneContactExist_thenAddContact() {
        vm.contactName = "TestName"
        let initialContactList = vm.pm.fetchContact()
        XCTAssertEqual(initialContactList.count, 0)
        
        vm.createContact()
        let contactList = vm.pm.fetchContact()
        XCTAssertEqual(contactList.count, 1)
        XCTAssertEqual(contactList[0].name, vm.contactName)
    }
    
    func testupdateContact_WhenInit_thenUpdateFavoriteJob() {
        vm.contactName = "TestName"
        vm.jobId = "idString"
        vm.createContact()
        let contactList = vm.pm.fetchContact()
        XCTAssertEqual(contactList.count, 1)
        XCTAssertEqual(contactList[0].name, vm.contactName)
        vm.contactName = ""
        XCTAssertEqual(vm.contactName, "")
        vm.initContact(actualContact: ContactDisplayable(contact: contactList[0], contactId: contactList[0].id!))
        XCTAssertEqual(vm.contactName, "TestName")
        vm.contactName = "name updated"
        vm.updateContact(actualContact: ContactDisplayable(contact: contactList[0], contactId: contactList[0].id!))
        let contactUpdated = try? vm.pm.fetchContactById(contactId: contactList[0].id!)
        XCTAssertEqual(contactUpdated!.name, "name updated")
    }
    
    func testActionToDo_whenActualContactIsNil_thenCreate(){
        vm.contactName = "actualContact is nil"
        vm.actionToDo(actualContact: nil)
        let updated = vm.pm.fetchContactWhoStartBy(name: "actu")
        XCTAssertEqual(updated.first?.name, vm.contactName)
    }
    
    func testActionToDo_whenActualContactExist_thenUpdate(){
        vm.pm.createContact(jobId: job.id!, name: "lala", compagny: "", functionInCompany: "", contactMail: "", contactPhoneNumber: "")
        let contactBeforeUpdate = vm.pm.fetchContactWhoStartBy(name: "la").first
        XCTAssertEqual(contactBeforeUpdate?.name, "lala")
        vm.contactName = "updated"
        vm.actionToDo(actualContact: ContactDisplayable(contact: contactBeforeUpdate!, contactId: (contactBeforeUpdate?.id)!))
        
        let contactAfterUpdate = vm.pm.fetchContactWhoStartBy(name: "up").first
        XCTAssertEqual(contactAfterUpdate?.name, "updated")
    }

}
