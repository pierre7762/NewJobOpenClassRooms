//
//  PoleEmploiFakeService.swift
//  NewJobTests
//
//  Created by Pierre on 09/12/2022.
//

import Foundation
@testable import NewJob

class PoleEmploiFakeService: PoleEmploiProtocol {
    // def du paramètre
    let tokenResult: Result<NewJob.PoleEmploiToken, NewJob.NetworkErrors>
    let jobResult: Result<NewJob.PoleEmploiResponse, NewJob.NetworkErrors>
    var reciveToken = ""
    
    // initialisation du param du dessus
    init(tokenResult: Result<NewJob.PoleEmploiToken, NewJob.NetworkErrors>, jobResult: Result<NewJob.PoleEmploiResponse, NewJob.NetworkErrors>) {
        self.tokenResult = tokenResult
        self.jobResult = jobResult
    }
    
    
    // function provenant de poleEmploi service grâce au protocol PoleEmploiProtocol
    func getPoleEmploiToken(callback: @escaping (Result<NewJob.PoleEmploiToken, NewJob.NetworkErrors>) -> Void) {
        callback(tokenResult)
    }
    
    // dans activeToken passer le résultat du
    func getPoleEmploiJobs(search: NewJob.Search, activeToken: String, callback: @escaping (Result<NewJob.PoleEmploiResponse, NewJob.NetworkErrors>) -> Void) {
        self.reciveToken = activeToken
        callback(jobResult)
    }
}
