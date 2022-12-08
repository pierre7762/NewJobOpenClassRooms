//
//  RelaunchDetailsViewModelTest.swift
//  NewJobTests
//
//  Created by Pierre on 29/11/2022.
//

import XCTest
@testable import NewJob

final class RelaunchDetailsViewModelTest: XCTestCase {
    var pmTest: PersistenceManager!
    var vm: RelaunchDetailsViewModel!
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
        vm = RelaunchDetailsViewModel()
        vm.pm = pmTest
    }
    
    override func tearDown() {
        super.tearDown()
        pmTest = nil
        vm = nil
    }
    
    // MARK: - Tests
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
    
    func testRemoveRelaunch_WhenOneRelaunchInMemory_ThenRemoveAllRelaunch() {
        pmTest.createSelectedJob(job: resultatJobTest)
        pmTest.createCandidacy(candidacyMeans: "", candidacyDate: Date.now, comment: "", favoriteJobId: "idString")
        let selectedJob = pmTest.fetchSelectedJobs(onlyInProgress: false).first
        let relaunches = pmTest.fetchAllRelaunchesfromCandidacyId(candidacyId: (selectedJob?.candidacy?.id)!, ascendingDate: true)
        XCTAssertEqual(relaunches.count, 0)
        
        pmTest.createRelaunch(candidacyID: (selectedJob?.candidacy?.id)!, contact: nil, date: Date.now, comment: "comment test", means: "Mail")
        let relaunchesAfterAdding = pmTest.fetchAllRelaunchesfromCandidacyId(candidacyId: (selectedJob?.candidacy?.id)!, ascendingDate: true)
        XCTAssertEqual(relaunchesAfterAdding.count, 1)
        vm.removeRelaunch(relaunchID: relaunchesAfterAdding[0].id!, pmDirect: vm.pm!)
        let relaunchesAfterRemoving = pmTest.fetchAllRelaunchesfromCandidacyId(candidacyId: (selectedJob?.candidacy?.id)!, ascendingDate: true)
        XCTAssertEqual(relaunchesAfterRemoving.count, 0)
    }

}
