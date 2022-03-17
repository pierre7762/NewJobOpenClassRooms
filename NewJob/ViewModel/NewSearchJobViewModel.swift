//
//  NewSearchJobViewModel.swift
//  NewJob
//
//  Created by Pierre on 16/02/2022.
//

import Foundation

class NewSearchJobViewModel: ObservableObject {
    // MARK: Internal var
    private var poleEmploiToken = ""
    @Published var citys: [City] = []
    @Published var showCitys = true
    @Published var citySelected = ""
    var cityNameWritenByUser: String = ""
    @Published var name = "test"
    @Published var jobs: [Resultat] = []
    @Published var search = Search()
    @Published var showResult = false
//    @Published var citysArrayFromApiGouv: CityGeoAPIResponse?
//    @Published var citysArrayFromApiGouv: [CityGeoAPIResponseElement] = []
    
    // MARK: Internal functions
    func getOffersOnPoleEmploi() {
        fetchPoleEmploiJobs()
        print(poleEmploiToken)
//        showResult = true
    }
    
    
    // MARK: Private var
    private let poleEmploiService = PoleEmploiService()
    private let apiGouvService = ApiGouvService()
    
    // MARK: Private functions
    
    func fetchCityCodeFromCityName() {
        citys = []
//        if search.city.count > 2 {
            print(search.city.count)
            apiGouvService.fetchCityCode(cityName: search.city) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let cityDatas):
                        if cityDatas.count > 4 {
                            for i in 0...3 {
                                self.citys.append(City(name: cityDatas[i].nom, codeInsee: cityDatas[i].code, postCode: "", deptCode: cityDatas[i].codeDepartement))
                            }
                            if self.citySelected.elementsEqual(self.search.city) {
                                self.showCitys = false
                            } else {
                                self.showCitys = true
                            }
                        } else {
                            for item in cityDatas {
                                self.citys.append(City(name: item.nom, codeInsee: item.code, postCode: "", deptCode: item.codeDepartement))
                            }
                        } 
                    case .failure(let error):
                        print(error)
                    }
                }
            }
//        }
        
    }
    
    func updateCodeInsee(codeInsee: String, name: String) {
        
        search.cityCode = codeInsee
        search.city = name
        citys = []
        citySelected = name
        
        if citySelected.elementsEqual(search.city) {
            showCitys = false
        } else {
            showCitys = true
        }
    }
    
    private func fetchPoleEmploiJobs() {
        
        poleEmploiService.getPoleEmploiToken { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let tokenObject):
                    self.poleEmploiToken = tokenObject.accessToken
                    self.poleEmploiService.getPoleEmploiJobs(search: self.search, activeToken: tokenObject.accessToken ){ result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let jobsObject):
//                                print(jobsObject)
                                self.jobs = jobsObject.resultats
                                self.showResult = true
                                print(jobsObject.resultats.count, self.showResult)

                            case .failure(let error):
                                print(error)
                            }
                        }
                    }

                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
