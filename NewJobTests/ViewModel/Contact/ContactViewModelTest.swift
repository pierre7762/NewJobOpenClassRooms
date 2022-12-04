////
////  ContactViewModelTest.swift
////  NewJobTests
////
////  Created by Pierre on 30/11/2022.
////
//
//import XCTest
//@testable import NewJob
//
//final class ContactViewModelTest: XCTestCase {
//    var coreDataStack: FakeCoreDataStack!
//    var pmTest: PersistenceManager!
//    var vm: ContactViewModel!
//    let resultatJobTest = Resultat(
//        id: "idString",
//        intitule: "JobCreationTest",
//        resultatDescription:"",
//        dateCreation: "",
//        lieuTravail: LieuTravail(libelle: "placeOfJobTest", latitude: nil, longitude: nil, codepostal: "test", commune: "testTown"),
//        entreprise: Entreprise(nom: "CompagnyTest", entrepriseDescription: nil, entrepriseAdaptee: true),
//        appellationlibelle: nil,
//        salaire: Salaire(libelle: "test", commentaire: nil, complement1: nil, complement2: nil),
//        origineOffre: OrigineOffre(origine: "string origin", urlOrigine: "urlOrigine", partenaires: [Partenaire(nom: "partenaireNAme", url: "url", logo: "logo")])
//    )
//
//    // MARK: - Tests Life Cycle
//    override func setUp() {
//        super.setUp()
//        coreDataStack = FakeCoreDataStack()
//        pmTest = PersistenceManager(inMemory: true)
//        vm = ContactViewModel()
//        vm.pm = pmTest
//        vm.pm.createSelectedJob(job: resultatJobTest)
//        vm.pm.createCandidacy(candidacyMeans: "Mail", candidacyDate: Date.now, comment: "Comment", favoriteJobId: "idString")
//        vm.pm.createContact(jobId: "idString", name: "Dupont", compagny: "Dupont&Co", functionInCompany: "CIO", contactMail: "dupont@dupont&co.fr", contactPhoneNumber: "0600000000")
//    }
//    
//    override func tearDown() {
//        super.tearDown()
//        pmTest = nil
//        coreDataStack = nil
//        vm = nil
//    }
//    
//    // MARK: - Tests
//    func testGetContactsList_WhenOneContactSave_thenReturnOneContact() {
//        XCTAssertEqual(vm.contacts.count, 0)
//        vm.getContactsList()
//        XCTAssertEqual(vm.contacts.count, 1)
//    }
//    
//    func testDelete_WhenOneContactSave_thenReturnZeroContact() {
//        XCTAssertEqual(vm.contacts.count, 0)
//        vm.getContactsList()
//        XCTAssertEqual(vm.contacts.count, 1)
//        vm.deleteContact(id: vm.contacts[0].id!)
//        XCTAssertEqual(vm.contacts.count, 0)
//    }
//
//
//}
