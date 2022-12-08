//
//  ActionsToBeTakenOnFavoriteJobViewModelTest.swift
//  NewJobTests
//
//  Created by Pierre on 29/11/2022.
//

import XCTest
@testable import NewJob

final class ActionsToBeTakenOnFavoriteJobViewModelTest: XCTestCase {
    var pmTest: PersistenceManager!
    var vm: ActionsToBeTakenOnFavoriteJobViewModel!
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
        vm = ActionsToBeTakenOnFavoriteJobViewModel()
        vm.pm = pmTest
        vm.pm.createSelectedJob(job: resultatJobTest)
        vm.favoriteJob = try? vm.pm.getSelectedJobWithId(id: "idString")
    }
    
    override func tearDown() {
        super.tearDown()
        pmTest = nil
        vm = nil
    }
    
    // MARK: - Tests
    func testInitFavoriteJob_WhenPassJobIdWithoutCandidacy_ThenInitViewModel() {
        vm.initFavoriteJob(jobId: "idString")
    }
    func testInitFavoriteJob_WhenPassJobIdWithCandiday_ThenInitViewModel() {
        vm.toDoAction(isCreated: true)
        vm.initFavoriteJob(jobId: "idString")
        XCTAssertEqual(vm.favoriteJob?.candidacy?.candidacyMeans, "Non précisé")
    }
    
    func testCreateRemoveCandidady_WhenItsACreation_ThenCreateTheCandidacy() {
        XCTAssertEqual(vm.favoriteJob?.candidacy, nil)
        vm.toDoAction(isCreated: true)
        XCTAssertEqual(vm.favoriteJob?.candidacy?.candidacyMeans, "Non précisé")
    }
    
    func testCreateRemoveCandidady_WhenItsARemoving_ThenRemoveTheCandidacy() {
        XCTAssertEqual(vm.favoriteJob?.candidacy, nil)
        vm.toDoAction(isCreated: true)
        XCTAssertEqual(vm.favoriteJob?.candidacy?.candidacyMeans, "Non précisé")

        vm.toDoAction(isCreated: false)
        XCTAssertEqual(vm.favoriteJob?.candidacy, nil)
    }
    
    func testUpdateCandidady_WhenUpdate_ThenUpdateTheCandidacy() {
        vm.toDoAction(isCreated: true)
        vm.initFavoriteJob(jobId: "idString")
        XCTAssertEqual(vm.favoriteJob?.candidacy?.candidacyMeans, "Non précisé")
        
        vm.means = "Mail"
        vm.updateCandidacy()
        XCTAssertEqual(vm.favoriteJob?.candidacy?.candidacyMeans, "Mail")
    }
    
    func testCheckIfCandidacyFormIsDifferentOfFavoriteJobCandidacy_WhenMeansChange_ThenReturnTrue() {
        vm.toDoAction(isCreated: true)
        vm.initFavoriteJob(jobId: "idString")
        XCTAssertEqual(vm.favoriteJob?.candidacy?.candidacyMeans, "Non précisé")
        vm.means = "Mail"
        let meansChange = vm.checkIfCandidacyFormIsDifferentOfFavoriteJobCandidacy()
        XCTAssertTrue(meansChange)
    }
    
    func testCheckIfCandidacyFormIsDifferentOfFavoriteJobCandidacy_WhenCommentChange_ThenReturnTrue() {
        vm.toDoAction(isCreated: true)
        vm.initFavoriteJob(jobId: "idString")
        XCTAssertEqual(vm.favoriteJob?.candidacy?.candidacyMeans, "Non précisé")
        vm.comment = "testComment"
        let commentChange = vm.checkIfCandidacyFormIsDifferentOfFavoriteJobCandidacy()
        XCTAssertTrue(commentChange)
    }
    
    func testCheckIfCandidacyFormIsDifferentOfFavoriteJobCandidacy_WhenDateChange_ThenReturnTrue() {
        vm.toDoAction(isCreated: true)
        vm.initFavoriteJob(jobId: "idString")
        XCTAssertEqual(vm.favoriteJob?.candidacy?.candidacyMeans, "Non précisé")
        vm.createDateCandidacy = Date.now
        let dateChange = vm.checkIfCandidacyFormIsDifferentOfFavoriteJobCandidacy()
        XCTAssertTrue(dateChange)
    }
    
    func testCheckIfCandidacyFormIsDifferentOfFavoriteJobCandidacy_WhenResultChange_ThenReturnTrue() {
        vm.toDoAction(isCreated: true)
        vm.initFavoriteJob(jobId: "idString")
        XCTAssertEqual(vm.favoriteJob?.candidacy?.candidacyMeans, "Non précisé")
        vm.textCandidacyState = "modif"
        let resultChange = vm.checkIfCandidacyFormIsDifferentOfFavoriteJobCandidacy()
        XCTAssertTrue(resultChange)
    }
    
    func testCheckIfCandidacyFormIsDifferentOfFavoriteJobCandidacy_WhenNothingChange_ThenReturnFalse() {
        vm.toDoAction(isCreated: true)
        vm.initFavoriteJob(jobId: "idString")
        XCTAssertEqual(vm.favoriteJob?.candidacy?.candidacyMeans, "Non précisé")
        let nothingChange = vm.checkIfCandidacyFormIsDifferentOfFavoriteJobCandidacy()
        XCTAssertFalse(nothingChange)
    }
    
    func testCandidacyIsCreated_WhenItstrue_ThenToggleIsAtTrue() {
        vm.toDoAction(isCreated: true)
        vm.candidacyIsCreated()
        XCTAssertTrue(vm.createCandidacyToggle)
    }
    
    func testCandidacyIsCreated_WhenItsFalse_ThenToggleIsAtFalse() {
        vm.candidacyIsCreated()
        XCTAssertFalse(vm.createCandidacyToggle)
    }
    
    func testConverteDateToString_WhenGivenDateInDateFormat_ThenShouldReturnDateInString() {
        var dateComponent = DateComponents()
        dateComponent.year = 2019
        dateComponent.month = 12
        dateComponent.day = 12
        dateComponent.timeZone = TimeZone(abbreviation: "CET")
        dateComponent.hour = 12
        dateComponent.minute = 34
        dateComponent.second = 55
        let date = NSCalendar.current.date(from: dateComponent)
        let result = vm.converteDateToString(date: date!)
        
        XCTAssertEqual(result, "12 déc. 2019")
    }
    
    func testFetchSelectedJob_whenExist_thenUpdateFavoriteJob() {
        vm.pm.createSelectedJob(job: resultatJobTest)
        vm.pm.createCandidacy(candidacyMeans: "Mail", candidacyDate: Date.now, comment: "", favoriteJobId: resultatJobTest.id)
        vm.fetchSelectedJob()
        XCTAssertEqual(vm.favoriteJob!.candidacy?.state, "En cours")
        vm.pm.updateSelectedJobCandidacy(jobId: resultatJobTest.id, candidacyDate: nil, candidacyMeans: nil, comment: nil, state: "Validée")
        vm.fetchSelectedJob()
        XCTAssertEqual(vm.favoriteJob!.candidacy?.state, "Validée")
    }
    
    func testRemoveInterview_WhenInterviewCountIsAtOne_ThenInterviewArrayCountIsZero() {
        vm.toDoAction(isCreated: true)
        vm.pm.createInterview(candidacyID: (vm.favoriteJob?.candidacy?.id)!, contact: nil, date: Date.now, comment: "")
        vm.interviewArray = vm.pm.fetchAllInterviewFromCandidacyId(candidacyId: (vm.favoriteJob?.candidacy?.id)!, ascendingDate: true)
        XCTAssertEqual(vm.interviewArray.count, 1)
        let interViewArray = vm.pm.fetchAllInterviewFromCandidacyId(candidacyId: (vm.favoriteJob?.candidacy?.id)!, ascendingDate: true)
        vm.removeInterview(interviewId: interViewArray[0].id!)
        XCTAssertEqual(vm.interviewArray.count, 0)
    }
    
    func testRemoveSelectedJob_WhenIsSelected_ThenRemoveIt() {
        vm.removeSelectedJob(jobId: (vm.favoriteJob?.id)!)
        let result = vm.pm.fetchSelectedJobs(onlyInProgress: false)
        XCTAssertEqual(result.count, 0)
    }
    
    func testFetchRelaunches_WhenDontExist_ThenReturnZero() {
        vm.pm.createSelectedJob(job: resultatJobTest)
        vm.pm.createCandidacy(candidacyMeans: "Mail", candidacyDate: Date.now, comment: "", favoriteJobId: resultatJobTest.id)
        vm.fetchRelaunches()
        XCTAssertEqual(vm.relaunchesArray.count, 0)

    }
}
