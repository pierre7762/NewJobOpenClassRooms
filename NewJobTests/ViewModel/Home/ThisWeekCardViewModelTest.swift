//
//  ThisWeekCardViewModelTest.swift
//  NewJobTests
//
//  Created by Pierre on 05/12/2022.
//

import XCTest
@testable import NewJob
 
final class ThisWeekCardViewModelTest: XCTestCase {
    var pmTest: PersistenceManager!
    var vm: ThisWeekCardViewModel!
    let resultatJobTest1 = Resultat(
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
    let resultatJobTest2 = Resultat(
        id: "idString2",
        intitule: "JobCreationTest2",
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
        initTest()
    }

    override func tearDown() {
        super.tearDown()
        pmTest = nil
        vm = nil
    }
    
    func initTest() {
        pmTest = PersistenceManager(inMemory: true)
        vm = ThisWeekCardViewModel()
        vm.pm = pmTest
        vm.pm.createSelectedJob(job: resultatJobTest1)
        vm.pm.updateSelectedJobCandidacy(jobId: resultatJobTest1.id, candidacyDate: Date().removing(days: 30), candidacyMeans: nil, comment: nil, state: nil)
        vm.pm.createCandidacy(candidacyMeans: "Mail", candidacyDate: Date().removing(days: 25), comment: "", favoriteJobId: resultatJobTest1.id)
        let job1 = try? vm.pm.getSelectedJobWithId(id: resultatJobTest1.id)
        vm.pm.createInterview(candidacyID: (job1!.candidacy?.id)!, contact: nil, date: Date().removing(days: 15), comment: "")
        
        vm.pm.createSelectedJob(job: resultatJobTest2)
        vm.pm.updateSelectedJobCandidacy(jobId: resultatJobTest2.id, candidacyDate: Date().removing(days: 30), candidacyMeans: nil, comment: nil, state: nil)
        vm.pm.createCandidacy(candidacyMeans: "Mail", candidacyDate: Date().removing(days: 20), comment: "", favoriteJobId: resultatJobTest2.id)
    }

    // MARK: - Tests

    func testFetchAllCandidacyCount_WhenTwoCandidacy_ThenShouldReturnTwo() {
        let expectation = 2
        vm.updateData()
        XCTAssertEqual(vm.allCandidacyCount, expectation)
    }

    func testFetchAllInterviewsCount_WhenTwoCandidacy_ThenShouldReturnTwo() {
        let expectation = 1
        vm.updateData()
        XCTAssertEqual(vm.allInterviewsCount, expectation)
    }
    
    func testHowMAnyDaysToHaveFridayInThisWeek_whenGiveNumberBetween1To7_ThenReturnNumberToAdd() {
        let caseOne = vm.howMAnyDaysToHaveFridayInThisWeek(currentWeekDay: 1)
        XCTAssertEqual(caseOne, 5)
        let caseTwo = vm.howMAnyDaysToHaveFridayInThisWeek(currentWeekDay: 2)
        XCTAssertEqual(caseTwo, 4)
        let caseThree = vm.howMAnyDaysToHaveFridayInThisWeek(currentWeekDay: 3)
        XCTAssertEqual(caseThree, 3)
        let caseFour = vm.howMAnyDaysToHaveFridayInThisWeek(currentWeekDay: 4)
        XCTAssertEqual(caseFour, 2)
        let caseFive = vm.howMAnyDaysToHaveFridayInThisWeek(currentWeekDay: 5)
        XCTAssertEqual(caseFive, 1)
        let caseSix = vm.howMAnyDaysToHaveFridayInThisWeek(currentWeekDay: 6)
        XCTAssertEqual(caseSix, 0)
        let caseSeven = vm.howMAnyDaysToHaveFridayInThisWeek(currentWeekDay: 7)
        XCTAssertEqual(caseSeven, -1)
        let caseOther = vm.howMAnyDaysToHaveFridayInThisWeek(currentWeekDay: 10)
        XCTAssertEqual(caseOther, 0)
    }

    func testGetCandidacyToBeRelaunch_whenExistOne_thenReturnOne() {
        let job2 = try? vm.pm.getSelectedJobWithId(id: resultatJobTest2.id)
        vm.pm.createRelaunch(candidacyID: (job2?.candidacy?.id)!, contact: nil, date: Date().removing(days: 8), comment: "", means: "Mail")
        vm.getCandidacyToBeRelaunch()
        
        XCTAssertEqual(vm.relaunchToBeRelanchThisWeekCount, 1)
    }
    
    func testGetCandidacyToBeRelaunch_whenExistOneInterviewToRelaunch_thenReturnOne() {
        vm.getCandidacyToBeRelaunch()
        
        XCTAssertEqual(vm.interviewsToBeRelaunchThisWeekCount, 1)
    }
    
    func testGetCandidacyToBeRelaunch_whenExistOneInterviewWithRelaunch_thenReturnOne() {
        let job1 = try? vm.pm.getSelectedJobWithId(id: resultatJobTest1.id)
        vm.pm.createRelaunch(candidacyID: (job1?.candidacy?.id)!, contact: nil, date: Date().removing(days: 8), comment: "", means: "Mail")
        vm.getCandidacyToBeRelaunch()
        
        XCTAssertEqual(vm.interviewsToBeRelaunchThisWeekCount, 1)
    }
}
