//
//  NewSearchJobViewModelTest.swift
//  NewJobTests
//
//  Created by Pierre on 30/11/2022.
//

import XCTest
@testable import NewJob

final class NewSearchJobViewModelTest: XCTestCase {
    var vm: NewSearchJobViewModel!
    let fakePoleEmploiResult = FakePoleEmploiResult()
    // MARK: - Tests Life Cycle
    override func setUp() {
        super.setUp()
        let token = getPoleEmploiToken()
        let response = getPoleEmploiResult()
        vm = NewSearchJobViewModel(poleEmploiService: PoleEmploiFakeService(tokenResult: .success(token), jobResult: .success(response)))
    }
    
    override func tearDown() {
        super.tearDown()
        vm = nil
    }
    
    // MARK: - Functions
    func getPoleEmploiToken() -> PoleEmploiToken {
        PoleEmploiToken(accessToken: "tokenxxxx", scope: "", tokenType: "", expiresIn: 60)
    }
    
    func getPoleEmploiResult() -> PoleEmploiResponse {
        let fakePoleEmploiResult = FakePoleEmploiResult()
        let results = fakePoleEmploiResult.getFakePoleEmploiResultJobs()
        let filters = fakePoleEmploiResult.getFakeFiltresPossibles()
        
        return PoleEmploiResponse(resultats: results, filtresPossibles: filters)
    }
    
    // MARK: - Tests
    
    func testGetOffersOnPoleEmploi_vhen_then() {
        vm.getOffersOnPoleEmploi()
        XCTAssertTrue(vm.showResult)
    }
    
    func testFetchCityCodeFromCityName_when_thens() {
        let expected = true
        let responseTest = [
            CityGeoAPIResponseElement(nom: "city1", code: "1", codeDepartement: "1"),
            CityGeoAPIResponseElement(nom: "city2", code: "2", codeDepartement: "2"),
            CityGeoAPIResponseElement(nom: "city3", code: "3", codeDepartement: "3"),
            CityGeoAPIResponseElement(nom: "city4", code: "4", codeDepartement: "3"),
            CityGeoAPIResponseElement(nom: "city5", code: "4", codeDepartement: "4"),
        ]
        let vmTest = NewSearchJobViewModel(apiGouvService: ApiGouvFakeService(tokenResult: .success(responseTest)))
        vmTest.fetchCityCodeFromCityName(cityName: "arras")
        
        XCTAssertTrue(expected)
    }
    
    func testFetchCityCodeFromCityName_when_thenFailure() {
        let vmTest = NewSearchJobViewModel(apiGouvService: ApiGouvFakeService(tokenResult: .failure(.undecodableData)))
        vmTest.fetchCityCodeFromCityName(cityName: "arras")
        
        XCTAssertFalse(vm.showResult)
    }
    
    func testFetchCityCodeFromCityName_when_thenSuccess() {
        let responseTest = [
            CityGeoAPIResponseElement(nom: "city1", code: "1", codeDepartement: "1"),
            CityGeoAPIResponseElement(nom: "city2", code: "2", codeDepartement: "2"),
            CityGeoAPIResponseElement(nom: "city3", code: "3", codeDepartement: "3"),
            CityGeoAPIResponseElement(nom: "city4", code: "4", codeDepartement: "3"),
        ]
        let vmTest = NewSearchJobViewModel(apiGouvService: ApiGouvFakeService(tokenResult: .success(responseTest)))
        vmTest.fetchCityCodeFromCityName(cityName: "arras")
        
        XCTAssertTrue(!vm.showResult)
    }
    
    
    func testUpdateCodeInsee_WhenNameIsArras_thenReturnResult() {
        let vm = NewSearchJobViewModel()
        XCTAssertEqual(vm.search.city, "")
        XCTAssertEqual(vm.search.cityCode, "")
        XCTAssertEqual(vm.citySelected, "")
        vm.updateCodeInsee(codeInsee: "62041", name: "Arras")
        XCTAssertEqual(vm.search.city, "Arras")
        XCTAssertEqual(vm.search.cityCode, "62041")
        XCTAssertEqual(vm.citySelected, "Arras")
    }
    
    func testFetchPoleEmploiJobs_when_thenFail () {
        let results = fakePoleEmploiResult.getFakePoleEmploiResultJobs()
        let filters = fakePoleEmploiResult.getFakeFiltresPossibles()
        let poleEmploiService = PoleEmploiFakeService(tokenResult: .failure(.invalidResponse), jobResult: .success(PoleEmploiResponse(resultats: results, filtresPossibles: filters)))
        vm = NewSearchJobViewModel(poleEmploiService: poleEmploiService)
        vm.fetchPoleEmploiJobs()
        XCTAssertEqual(vm.jobs.count, 0)
        XCTAssertFalse(vm.showResult)
    }
    
    func testFetchPoleEmploiJobs_whenCallPass_thenSuccess () {
        var searchObject = Search()
        searchObject.jobTitle = "Livreur"
        searchObject.codeInsee = "62041"
        searchObject.qualification = "0"
        searchObject.experience = "2"
        
        vm.search = searchObject
        vm.fetchPoleEmploiJobs()
        
        XCTAssertTrue(!vm.showResult)
    }
    
    func testFetchPoleEmploiJobs_whenCallPass_thenFailed () {
        let token = getPoleEmploiToken()
        let vmFailed = NewSearchJobViewModel(poleEmploiService: PoleEmploiFakeService(tokenResult: .success(token), jobResult: .failure(.invalidResponse)))
        var searchObject = Search()
        searchObject.jobTitle = "Livreur"
        searchObject.codeInsee = "62041"
        searchObject.qualification = "0"
        searchObject.experience = "2"
        
        vmFailed.search = searchObject
        vmFailed.fetchPoleEmploiJobs()
        XCTAssertFalse(vm.showResult)
    }
}
