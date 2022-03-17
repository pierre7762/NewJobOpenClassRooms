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
    let cityNames = CityGeoAPIResponse()
    var cityNameWritenByUser: String = ""
    @Published var name = "test"
    @Published var jobs: [Resultat] = []
    @Published var search = Search()
    @Published var showResult = false
    
    // MARK: Internal functions
    func getOffersOnPoleEmploi() {
        fetchPoleEmploiJobs()
        print(poleEmploiToken)
//        showResult = true
    }
    
    
    // MARK: Private var
    private let poleEmploiService = PoleEmploiService()
    
    // MARK: Private functions
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
