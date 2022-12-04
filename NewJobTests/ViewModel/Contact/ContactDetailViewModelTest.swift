//
//  ContactDetailViewModelTest.swift
//  NewJobTests
//
//  Created by Pierre on 30/11/2022.
//

import XCTest
@testable import NewJob

final class ContactDetailViewModelTest: XCTestCase {
    var pmTest: PersistenceManager!
    var vm: ContactDetailsViewModel!
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
        vm = ContactDetailsViewModel()
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
    func testDeleteContact_WhenOneContactSave_thenReturnZero() {
        var allContacts = vm.pm.fetchContact()
        XCTAssertEqual(allContacts.count, 1)
        let contact = try? vm.pm.fetchContactByName(name: "Dupont")
        vm.deleteContact(id: (contact?.id)!)
        allContacts = vm.pm.fetchContact()
        
        XCTAssertEqual(allContacts.count, 0)
    }
    
    func testFetchCandidaciesWhoAreConnectedAtThisContact_WhenOneContactSave_thenReturnOne() {
        let allContacts = vm.pm.fetchContact()
        XCTAssertEqual(allContacts.count, 1)
        let contact = try? vm.pm.fetchContactByName(name: "Dupont")
        vm.fetchCandidaciesWhoAreConnectedAtThisContact(contactID: (contact?.id)!)
        
        XCTAssertEqual(vm.candidacyArray.count, 1)
    }

}
