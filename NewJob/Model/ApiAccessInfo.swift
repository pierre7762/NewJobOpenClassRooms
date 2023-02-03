//
//  ApiAccessInfo.swift
//  NewJob
//
//  Created by Pierre on 14/01/2022.
//

import Foundation

struct ApiAccessInfo {
    let PoleEmploi = PoleEmploiAccess()
}

struct PoleEmploiAccess {
    let client_id = "PAR_newjob_6416a72235b39868ab77ea25e02e64d43804df63b8fb491bc0c45aab9fdfe9ea" // test
    let client_secret = "e19e7aa3b4afe88c741015fbc5041a266d67a713d5b6fbc414ee2c2d8de4cff3"
    let tokenBaseURL: String = "https://entreprise.pole-emploi.fr/connexion/oauth2/access_token?"
    let jobsBaseURL: String = "https://api.emploi-store.fr/partenaire/offresdemploi/v2/offres/search?"
}

struct ApiGouvAcess {
    let geoApiGouv: String = "https://geo.api.gouv.fr"
}


