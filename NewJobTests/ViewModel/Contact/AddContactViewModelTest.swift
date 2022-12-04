////
////  AddContactViewModelTest.swift
////  NewJobTests
////
////  Created by Pierre on 30/11/2022.
////
//
//import XCTest
//@testable import NewJob
//
//final class AddContactViewModelTest: XCTestCase {
//    var coreDataStack: FakeCoreDataStack!
//    var pmTest: PersistenceManager!
//    var vm: AddContactViewModel!
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
//    var job: SelectedJob!
//
//    // MARK: - Tests Life Cycle
//    override func setUp() {
//        super.setUp()
//        coreDataStack = FakeCoreDataStack()
//        pmTest = PersistenceManager(inMemory: false)
//        vm = AddContactViewModel()
//        vm.pm = pmTest
//        vm.pm.createSelectedJob(job: resultatJobTest)
//        vm.pm.createCandidacy(candidacyMeans: "Mail", candidacyDate: Date.now, comment: "", favoriteJobId: "idString")
//        job = vm.pm.fetchSelectedJobs().first
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
//    func testInitFavoriteJob_WhenInit_thenUpdateFavoriteJob() {
//        XCTAssertNil(vm.favoriteJob)
//        vm.initFavoriteJob(job: job)
//        XCTAssertEqual(vm.favoriteJob?.entitled, "JobCreationTest")
//    }
//    
//    func testCreateContact_WhenNoneContactExist_thenAddContact() {
//        vm.contactName = "TestName"
//        let initialContactList = vm.pm.fetchContact()
//        XCTAssertEqual(initialContactList.count, 0)
//        
//        vm.createContact()
//        let contactList = vm.pm.fetchContact()
//        XCTAssertEqual(contactList.count, 1)
//        XCTAssertEqual(contactList[0].name, vm.contactName)
//    }
//
//}
