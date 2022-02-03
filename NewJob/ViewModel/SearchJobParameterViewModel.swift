//
//  SearchJobParameterViewModel.swift
//  NewJob
//
//  Created by Pierre on 21/01/2022.
//

import Foundation

class SearchJobParameterViewModel: ObservableObject {
    // MARK: Internal var
    private var poleEmploiToken = ""
    let offers = PoleEmploiOffers()
    @Published var name = "test"
    @Published var jobs: [Job] = []
    
    // MARK: Internal functions
    func getOffersOnPoleEmploi() {
        fetchPoleEmploiJobs()
        print(poleEmploiToken)
    }
    
    
    // MARK: Private var
    private let poleEmploiService = PoleEmploiService()
    
    // MARK: Private functions
    func fetchPoleEmploiJobs() {
        poleEmploiService.getPoleEmploiToken { result in
            print("result.publisher")
            DispatchQueue.main.async {
                switch result {
                case .success(let tokenObject):
                    self.poleEmploiToken = tokenObject.accessToken
                    print(tokenObject.accessToken)
                    self.poleEmploiService.getPoleEmploiJobs(activeToken: tokenObject.accessToken ){ result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let jobsObject):
//                                print(jobsObject.resultats[3])
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
