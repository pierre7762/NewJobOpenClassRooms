//
//  JobDetailsViewModelTest.swift
//  NewJobTests
//
//  Created by Pierre on 30/11/2022.
//

import XCTest
@testable import NewJob

final class JobDetailsViewModelTest: XCTestCase {
    var pmTest: PersistenceManager!
    var vm: JobDetailsViewModel!
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
        vm = JobDetailsViewModel()
        vm.pm = pmTest
    }
    
    override func tearDown() {
        super.tearDown()
        pmTest = nil
        vm = nil
    }
    
    // MARK: - Tests
    func testModifyShowAllDescription_WhenFalse_thenReturnTrue() {
        XCTAssertFalse(vm.showAllDescription)
        vm.modifyShowAllDescription()
        XCTAssertTrue(vm.showAllDescription)
    }
    
    func testCheckIfIsFavorite_WhenFalse_thenReturnFalse() {
        XCTAssertFalse(vm.isFavorite)
        vm.checkIfIsFavorite(job: resultatJobTest)
        XCTAssertFalse(vm.isFavorite)
        vm.pm.createSelectedJob(job: resultatJobTest)
        vm.checkIfIsFavorite(job: resultatJobTest)
        XCTAssertTrue(vm.isFavorite)
    }

    func testDeleteThisFavorite_WhenSave_thenDelete() {
        vm.pm.createSelectedJob(job: resultatJobTest)
        vm.checkIfIsFavorite(job: resultatJobTest)
        XCTAssertTrue(vm.isFavorite)
        vm.deleteThisFavorite(selectedJobId: "idString")
        XCTAssertFalse(vm.isFavorite)
    }
    
    func testPrepareSaveJob_WhenIsNotFavorite_thenSaveJob() {
        XCTAssertFalse(vm.isFavorite)
        vm.prepareSaveJob(job: resultatJobTest)
        XCTAssertTrue(vm.isFavorite)
    }

}
