////
////  ActionsToBeTakenViewModelTest.swift
////  NewJobTests
////
////  Created by Pierre on 30/11/2022.
////
//
//import XCTest
//@testable import NewJob
//
//final class ActionsToBeTakenViewModelTest: XCTestCase {
//    var coreDataStack: FakeCoreDataStack!
//    var pmTest: PersistenceManager!
//    var vm: ActionToBeTakenViewModel!
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
//        vm = ActionToBeTakenViewModel()
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
//    func testGetCandidacyToBeRelaunch_WhenNoneJobSave_thenReturnUpadte() {
//        vm.getCandidacyToBeRelaunch(numberOfDayFrom: 5)
//        XCTAssertEqual(vm.candidaciesToBeRelanch.count, 0)
//        XCTAssertEqual(vm.relaunchToBeRelanch.count, 0)
//        XCTAssertEqual(vm.interviewsToBeRelaunch.count, 0)
//    }
//    
//    func testGetCandidacyToBeRelaunch_WhenOneJobSaveWithOneCandidacy_thenReturnUpdate() {
//        let candidacyDate = Date()
//            .removing(days: 6)
//        vm.pm.createSelectedJob(job: resultatJobTest)
//        vm.pm.createCandidacy(candidacyMeans: "Mail", candidacyDate: candidacyDate, comment: "", favoriteJobId: "idString")
//        vm.getCandidacyToBeRelaunch(numberOfDayFrom: 5)
//        
//        XCTAssertEqual(vm.candidaciesToBeRelanch.count, 1)
//        XCTAssertEqual(vm.relaunchToBeRelanch.count, 0)
//        XCTAssertEqual(vm.interviewsToBeRelaunch.count, 0)
//    }
//    
//    func testGetCandidacyToBeRelaunch_WhenOneJobSaveWithOneRelaunch_thenReturnUpdate() {
//        let candidacyDate = Date()
//            .removing(days: 12)
//        let relaunchDate = Date()
//            .removing(days: 6)
//        vm.pm.createSelectedJob(job: resultatJobTest)
//        vm.pm.createCandidacy(candidacyMeans: "Mail", candidacyDate: candidacyDate, comment: "", favoriteJobId: "idString")
//        let allCandidacies = vm.pm.fetchAllCandidacies()
//        let candidacy = allCandidacies.first
//        vm.pm.createRelaunch(candidacyID: (candidacy?.id!)!, contact: nil, date: relaunchDate, comment: "", means: "Mail")
//        vm.getCandidacyToBeRelaunch(numberOfDayFrom: 5)
//        
//        XCTAssertEqual(vm.candidaciesToBeRelanch.count, 0)
//        XCTAssertEqual(vm.relaunchToBeRelanch.count, 1)
//        XCTAssertEqual(vm.interviewsToBeRelaunch.count, 0)
//    }
//    
//    func testGetCandidacyToBeRelaunch_WhenOneJobSaveWithOneInterview_thenReturnUpdate() {
//        let candidacyDate = Date()
//            .removing(days: 12)
//        let relaunchDate = Date()
//            .removing(days: 10)
//        let interviewDate = Date()
//            .removing(days: 6)
//        vm.pm.createSelectedJob(job: resultatJobTest)
//        vm.pm.createCandidacy(candidacyMeans: "Mail", candidacyDate: candidacyDate, comment: "", favoriteJobId: "idString")
//        let allCandidacies = vm.pm.fetchAllCandidacies()
//        let candidacy = allCandidacies.first
//        vm.pm.createRelaunch(candidacyID: (candidacy?.id!)!, contact: nil, date: relaunchDate, comment: "", means: "Mail")
//        vm.pm.createInterview(candidacyID: (candidacy?.id)!, date: interviewDate, comment: "")
//        vm.getCandidacyToBeRelaunch(numberOfDayFrom: 5)
//        
//        XCTAssertEqual(vm.candidaciesToBeRelanch.count, 0)
//        XCTAssertEqual(vm.relaunchToBeRelanch.count, 0)
//        XCTAssertEqual(vm.interviewsToBeRelaunch.count, 1)
//    }
//    
//
//}
//
//public extension Date {
//    
//    func adding(days: Double) -> Date {
//        let seconds = Double(days) * 60 * 60 * 24
//        return addingTimeInterval(seconds)
//    }
//    
//    func adding(hours: Double) -> Date {
//        let seconds = Double(hours) * 60 * 60
//        return addingTimeInterval(seconds)
//    }
//    
//    func adding(minutes: Double) -> Date {
//        let seconds = Double(minutes) * 60
//        return addingTimeInterval(seconds)
//    }
//    
//    func adding(seconds: Double) -> Date {
//        addingTimeInterval(Double(seconds))
//    }
//    
//    func removing(days: Double) -> Date {
//        adding(days: -days)
//    }
//    
//    func removing(hours: Double) -> Date {
//        adding(hours: -hours)
//    }
//    
//    func removing(minutes: Double) -> Date {
//        adding(minutes: -minutes)
//    }
//    
//    func removing(seconds: Double) -> Date {
//        adding(seconds: -seconds)
//    }
//}
//
