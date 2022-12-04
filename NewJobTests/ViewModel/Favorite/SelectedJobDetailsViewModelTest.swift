//
//  SelectedJobDetailsViewModelTest.swift
//  NewJobTests
//
//  Created by Pierre on 29/11/2022.
//
//
//import XCTest
//@testable import NewJob
//
//final class SelectedJobDetailsViewModelTest: XCTestCase {
//    var coreDataStack: FakeCoreDataStack!
//    var pmTest: PersistenceManager!
//    var vm: SelectedJobDetailsViewModel!
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
//        vm = SelectedJobDetailsViewModel()
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
//    func testModifyShowAllDescription_WhenJobIsFavorite_ThenIsFAvoriteShouldBeTrue() {
//        XCTAssertFalse(vm.showAllDescription)
//        vm.modifyShowAllDescription()
//        XCTAssertTrue(vm.showAllDescription)
//    }
//    
//    func testCheckIfIsFavorite_WhenJobIsFavorite_ThenIsFAvoriteShouldBeTrue() {
//        vm.pm.createSelectedJob(job: resultatJobTest)
//        vm.pm.createCandidacy(candidacyMeans: "", candidacyDate: Date.now, comment: "", favoriteJobId: "idString")
//        vm.pm.createContact(jobId: "idString", name: "ContactName", compagny: "CompagnyName", functionInCompany: "RH", contactMail: "rh@test.fr", contactPhoneNumber: "06.00.00.00.00")
//        let jobs = vm.pm.fetchSelectedJobs()
//        let job = jobs.first
//
//        XCTAssertFalse(vm.isFavorite)
//
//        vm.job = job
//        vm.checkIfIsFavorite()
//
//        XCTAssertTrue(vm.isFavorite)
//    }
    
//    func testDeleteThisFavorite_WhenOneJobIsFavorite_ThenshouldReturnZero() {
//        vm.pm.createSelectedJob(job: resultatJobTest)
//        vm.pm.createCandidacy(candidacyMeans: "", candidacyDate: Date.now, comment: "", favoriteJobId: "idString")
//        let jobs = vm.pm.fetchSelectedJobs()
//        let job = jobs.first
//        
//        XCTAssertEqual(jobs.count, 1)
//        
//        vm.job = job
//        vm.deleteThisFavorite(selectedJobId: (vm.job?.id!)!)
//        let jobsAfterDelete = vm.pm.fetchSelectedJobs()
//        XCTAssertEqual(jobsAfterDelete.count, 0)
//    }
//
//}
