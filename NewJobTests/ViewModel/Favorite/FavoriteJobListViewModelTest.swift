////
////  FavoriteJobListViewModelTest.swift
////  NewJobTests
////
////  Created by Pierre on 30/11/2022.
////
//
//import XCTest
//@testable import NewJob
//
//final class FavoriteJobListViewModelTest: XCTestCase {
//    var coreDataStack: FakeCoreDataStack!
//    var pmTest: PersistenceManager!
//    var vm: FavoriteJobListViewModel!
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
//    let resultatJobTest2 = Resultat(
//        id: "idString2",
//        intitule: "JobCreationTest2",
//        resultatDescription:"",
//        dateCreation: "",
//        lieuTravail: LieuTravail(libelle: "placeOfJobTest2", latitude: nil, longitude: nil, codepostal: "test2", commune: "testTown2"),
//        entreprise: Entreprise(nom: "CompagnyTest2", entrepriseDescription: nil, entrepriseAdaptee: true),
//        appellationlibelle: nil,
//        salaire: Salaire(libelle: "test2", commentaire: nil, complement1: nil, complement2: nil),
//        origineOffre: OrigineOffre(origine: "string origin2", urlOrigine: "urlOrigine2", partenaires: [Partenaire(nom: "partenaireNAme2", url: "url2", logo: "logo2")])
//    )
//
//    // MARK: - Tests Life Cycle
//    override func setUp() {
//        super.setUp()
//        coreDataStack = FakeCoreDataStack()
//        pmTest = PersistenceManager(inMemory: true)
//        vm = FavoriteJobListViewModel()
//        vm.pm = pmTest
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
//    func testUpdateJobsList_WhenOneJobSave_thenReturnUpadte() {
//        vm.updateJobsList()
//        XCTAssertEqual(vm.jobsWithCandidacy.count, 0)
//        vm.pm.createSelectedJob(job: resultatJobTest)
//        vm.pm.createSelectedJob(job: resultatJobTest2)
//        vm.updateJobsList()
//        XCTAssertEqual(vm.jobsWithCandidacy.count, 2)
//    }
//    
//    func testDelete_WhenTwoJobsSave_thenReturnOneJob() {
//        vm.updateJobsList()
//        XCTAssertEqual(vm.jobsWithCandidacy.count, 0)
//        vm.pm.createSelectedJob(job: resultatJobTest)
//        vm.pm.createSelectedJob(job: resultatJobTest2)
//        let allJobs = vm.pm.fetchSelectedJobs()
//        let job = allJobs.first
//        vm.delete(job: job!)
//        XCTAssertEqual(vm.jobsWithCandidacy.count, 1)
//    }
//
//}
