//
//  SearchJobParameterViewModel.swift
//  NewJob
//
//  Created by Pierre on 21/01/2022.
//

import Foundation

class LastSearchJobViewModel: ObservableObject {
    // MARK: Internal var
    private var poleEmploiToken = ""
    let offers = PoleEmploiOffers()
    @Published var name = "test"
    @Published var jobs: [Resultat] = []
    private var search = Search(jobTitle: "chauffeur")
    
    // MARK: Internal functions
    func getOffersOnPoleEmploi() {
        fetchPoleEmploiJobs()
        print(poleEmploiToken)
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
    
    private func getOffers() {
        
    }
    
}
