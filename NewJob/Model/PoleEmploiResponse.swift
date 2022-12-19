//
//  PoleEmploiAPI.swift
//  NewJob
//
//  Created by Pierre on 11/01/2022.
//

import Foundation
import CoreData

// MARK: - PoleEmploiToken
struct PoleEmploiToken: Codable {
    let accessToken, scope, tokenType: String
    let expiresIn: Int

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case scope
        case tokenType = "token_type"
        case expiresIn = "expires_in"
    }
}

// MARK: - PoleEmploiResponse
struct PoleEmploiResponse: Codable {
    let resultats: [Resultat]
    let filtresPossibles: [FiltresPossible]
}

// MARK: - FiltresPossible
struct FiltresPossible: Codable {
    let filtre: String
    let agregation: [Agregation]
}

// MARK: - Agregation
struct Agregation: Codable {
    let valeurPossible: String
    let nbResultats: Int
}

// MARK: - Resultat
struct Resultat: Codable, Identifiable {
    let id, intitule, resultatDescription, dateCreation: String
    let lieuTravail: LieuTravail
    let entreprise: Entreprise
    let appellationlibelle: String?
    let salaire: Salaire
    let origineOffre: OrigineOffre
   

    enum CodingKeys: String, CodingKey {
        case id, intitule
        case resultatDescription = "description"
        case dateCreation, lieuTravail, entreprise, appellationlibelle, salaire, origineOffre
    }
}

// MARK: - Entreprise
struct Entreprise: Codable {
    let nom, entrepriseDescription: String?
    let entrepriseAdaptee: Bool?

    enum CodingKeys: String, CodingKey {
        case nom
        case entrepriseDescription = "description"
        case entrepriseAdaptee
    }
}

// MARK: - LieuTravail
struct LieuTravail: Codable {
    let libelle: String?
    let latitude, longitude: Double?
    let codepostal: String?
    let commune: String?
}

// MARK: - OrigineOffre
struct OrigineOffre: Codable {
    let origine: String
    let urlOrigine: String
    let partenaires: [Partenaire]
}

// MARK: - Partenaire
struct Partenaire: Codable {
    let nom: String
    let url: String
    let logo: String
}

// MARK: - Salaire
struct Salaire: Codable {
    let libelle, commentaire, complement1, complement2: String?
}


