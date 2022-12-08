//
//  FavoriteJobListViewModelTest.swift
//  NewJobTests
//
//  Created by Pierre on 30/11/2022.
//

import XCTest
@testable import NewJob

final class FavoriteJobListViewModelTest: XCTestCase {
    var pmTest: PersistenceManager!
    var vm: FavoriteJobListViewModel!
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
    let resultatJobTest2 = Resultat(
        id: "idString2",
        intitule: "JobCreationTest2",
        resultatDescription:"",
        dateCreation: "",
        lieuTravail: LieuTravail(libelle: "placeOfJobTest2", latitude: nil, longitude: nil, codepostal: "test2", commune: "testTown2"),
        entreprise: Entreprise(nom: "CompagnyTest2", entrepriseDescription: nil, entrepriseAdaptee: true),
        appellationlibelle: nil,
        salaire: Salaire(libelle: "test2", commentaire: nil, complement1: nil, complement2: nil),
        origineOffre: OrigineOffre(origine: "string origin2", urlOrigine: "urlOrigine2", partenaires: [Partenaire(nom: "partenaireNAme2", url: "url2", logo: "logo2")])
    )

    // MARK: - Tests Life Cycle
    override func setUp() {
        super.setUp()
        pmTest = PersistenceManager(inMemory: true)
        vm = FavoriteJobListViewModel()
        vm.pm = pmTest
    }
    
    override func tearDown() {
        super.tearDown()
        pmTest = nil
        vm = nil
    }
    
    // MARK: - Tests
    func testUpdateJobsList_WhenOneCandidacySave_thenReturnUpadte() {
        vm.updateJobsList()
        XCTAssertEqual(vm.jobsWithCandidacy.count, 0)
        vm.pm.createSelectedJob(job: resultatJobTest)
        vm.pm.createCandidacy(candidacyMeans: "Mail", candidacyDate: Date.now, comment: "", favoriteJobId: resultatJobTest.id)
        vm.pm.createSelectedJob(job: resultatJobTest2)
        vm.updateJobsList()
        XCTAssertEqual(vm.jobsWithCandidacy.count, 1)
    }
    
    func testUpdateJobsList_WhenAllIsSelected_thenReturnUpadte() {
        vm.updateJobsList()
        vm.searchOptionSelected = "Toutes"
        XCTAssertEqual(vm.jobsWithCandidacy.count, 0)
        vm.pm.createSelectedJob(job: resultatJobTest)
        vm.pm.createCandidacy(candidacyMeans: "Mail", candidacyDate: Date.now, comment: "", favoriteJobId: resultatJobTest.id)
        vm.pm.createSelectedJob(job: resultatJobTest2)
        vm.updateJobsList()
        XCTAssertEqual(vm.jobsWithCandidacy.count, 1)
        XCTAssertEqual(vm.jobsWithoutCandidacy.count, 1)
    }
    
    

}
