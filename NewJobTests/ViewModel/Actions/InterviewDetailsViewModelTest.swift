//
//  InterviewDetailsViewModelTest.swift
//  NewJobTests
//
//  Created by Pierre on 11/12/2022.
//

import XCTest
@testable import NewJob

final class InterviewDetailsViewModelTest: XCTestCase {
    var pmTest: PersistenceManager!
    var vm: InterviewDetailsViewModel!
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
        vm = InterviewDetailsViewModel()
        vm.pm = pmTest
    }
    
    override func tearDown() {
        super.tearDown()
        pmTest = nil
        vm = nil
    }
    
    // MARK: - Tests
    func testLoadInterviewDetails_when_then() {
        XCTAssertNil(vm.interview)
        vm.pm.createSelectedJob(job: resultatJobTest)
        vm.pm.createCandidacy(candidacyMeans: "mail", candidacyDate: Date.now, comment: "comment test", favoriteJobId: "idString")
        guard let candidacy = vm.pm.fetchAllCandidacies().first else { return }
        vm.pm.createInterview(candidacyID: candidacy.id!, contact: nil, date: Date.now, comment: "comment")
        guard let interview = vm.pm.fetchAllInterviews().first else { return }
        vm.loadInterviewDetails(interviewId: interview.id!)
        XCTAssertEqual(vm.interview, interview)
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
}
