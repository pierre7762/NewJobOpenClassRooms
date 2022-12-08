//
//  NewSearchJobViewModelTest.swift
//  NewJobTests
//
//  Created by Pierre on 30/11/2022.
//

import XCTest
@testable import NewJob

final class NewSearchJobViewModelTest: XCTestCase {
    var pmTest: PersistenceManager!
    var vm: NewSearchJobViewModel!
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
    
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionConfiguration
    }()

    // MARK: - Tests Life Cycle
    override func setUp() {
        super.setUp()
        pmTest = PersistenceManager(inMemory: true)
        vm = NewSearchJobViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        pmTest = nil
        vm = nil
    }
    
    // MARK: - Tests
    func testUpdateCodeInsee_WhenNameIsArras_thenReturnResult() {
        XCTAssertEqual(vm.search.city, "")
        XCTAssertEqual(vm.search.cityCode, "")
        XCTAssertEqual(vm.citySelected, "")
        vm.updateCodeInsee(codeInsee: "62041", name: "Arras")
        XCTAssertEqual(vm.search.city, "Arras")
        XCTAssertEqual(vm.search.cityCode, "62041")
        XCTAssertEqual(vm.citySelected, "Arras")
    }
    
    
    
    
//    func testFetchCityCodeFromCityName_WhenNameIsArras_thenReturnResult() {
//        let expectation = XCTestExpectation(description: "Get data from apiGouv")
//        XCTAssertEqual(vm.citys.count, 0)
//        vm.fetchCityCodeFromCityName(cityName: "Arras")
//
//
//
//        wait(for: [expectation], timeout: 10.0)
//        expectation.fulfill()
//        XCTAssertEqual(vm.citys.count, 4)
//        let fakeSession = URLSession(configuration: sessionConfiguration)
//        let sut: ApiGouvService = .init(session: fakeSession)
//    }


}
