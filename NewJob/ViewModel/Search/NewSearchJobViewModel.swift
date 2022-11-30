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
    @Published var showAlert = false
    @Published var requestInProgress = false
    
    
    // MARK: Internal functions
    func getOffersOnPoleEmploi() {
        requestInProgress.toggle()
        fetchPoleEmploiJobs()
        showResult = true
    }
    
    
    // MARK: var
    let poleEmploiService = PoleEmploiService()
    let apiGouvService = ApiGouvService()
    
    // MARK: functions
    func fetchCityCodeFromCityName(cityName: String) {
        citys = []
            apiGouvService.fetchCityCode(cityName: cityName) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let cityDatas):
//                        print(result)
                        if cityDatas.count > 4 {
                            for i in 0...3 {
                                self.citys.append(City(name: cityDatas[i].nom, codeInsee: cityDatas[i].code, postCode: "", deptCode: cityDatas[i].codeDepartement))
                            }
                            if self.citySelected.elementsEqual(cityName) {
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
                        self.requestInProgress.toggle()
                        self.showAlert = true
                    }
                }
            }
        
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
                    self.requestInProgress.toggle()
                    self.poleEmploiToken = tokenObject.accessToken
                    self.poleEmploiService.getPoleEmploiJobs(search: self.search, activeToken: tokenObject.accessToken ){ result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let jobsObject):
                                self.jobs = jobsObject.resultats
                                self.showResult = true

                            case .failure(let error):
                                print(error)
                                self.showAlert = true
                            }
                        }
                    }

                case .failure(let error):
                    self.requestInProgress.toggle()
                    print(error)
                }
            }
        }
    }
}
