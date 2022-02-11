//
//  PoleEmploiAPI.swift
//  NewJob
//
//  Created by Pierre on 11/01/2022.
//

import Foundation

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


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let poleEmploiResponse = try? newJSONDecoder().decode(PoleEmploiResponse.self, from: jsonData)

import Foundation

// MARK: - PoleEmploiResponse
struct PoleEmploiResponse: Codable {
    let resultats: [Job]
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
struct Job: Codable, Identifiable {
    let id, intitule, resultatDescription, dateCreation: String
    let dateActualisation: String
    let lieuTravail: LieuTravail
    let romeCode, romeLibelle, appellationlibelle: String
    let entreprise: Entreprise
    let typeContrat: TypeContrat
    let typeContratLibelle: TypeContratLibelle
    let natureContrat: NatureContrat
    let experienceExige: ExperienceExige
    let experienceLibelle: ExperienceLibelle
    let salaire: Salaire
    let alternance: Bool
    let nombrePostes: Int
    let accessibleTH: Bool
    let qualificationCode: String
    let qualificationLibelle: QualificationLibelle
    let secteurActivite, secteurActiviteLibelle: String?
    let origineOffre: OrigineOffre
    let dureeTravailLibelle, dureeTravailLibelleConverti: String?

    enum CodingKeys: String, CodingKey {
        case id, intitule
        case resultatDescription = "description"
        case dateCreation, dateActualisation, lieuTravail, romeCode, romeLibelle, appellationlibelle, entreprise, typeContrat, typeContratLibelle, natureContrat, experienceExige, experienceLibelle, salaire, alternance, nombrePostes, accessibleTH, qualificationCode, qualificationLibelle, secteurActivite, secteurActiviteLibelle, origineOffre, dureeTravailLibelle, dureeTravailLibelleConverti
    }
}

// MARK: - Entreprise
struct Entreprise: Codable {
    let entrepriseDescription: String?
    let entrepriseAdaptee: Bool
    let nom: String?

    enum CodingKeys: String, CodingKey {
        case entrepriseDescription = "description"
        case entrepriseAdaptee, nom
    }
}

enum ExperienceExige: String, Codable {
    case d = "D"
    case e = "E"
}

enum ExperienceLibelle: String, Codable {
    case débutantAccepté = "Débutant accepté"
    case expérienceExigée = "Expérience exigée"
    case expérienceExigéeDe2AnS = "Expérience exigée de 2 An(s)"
}

// MARK: - LieuTravail
struct LieuTravail: Codable {
    let libelle: String
    let latitude, longitude: Double
    let commune: String
}

enum NatureContrat: String, Codable {
    case contratTravail = "Contrat travail"
}

// MARK: - OrigineOffre
struct OrigineOffre: Codable {
    let origine: String
    let urlOrigine: String
    let partenaires: [Partenaire]
}

// MARK: - Partenaire
struct Partenaire: Codable {
    let nom: Nom
    let url: String
    let logo: String
}

enum Nom: String, Codable {
    case apec = "APEC"
    case beetween = "BEETWEEN"
    case careerbuilder = "CAREERBUILDER"
    case jobijoba = "JOBIJOBA"
    case meteojob = "METEOJOB"
}

enum QualificationLibelle: String, Codable {
    case agentDeMaîtrise = "Agent de maîtrise"
    case employéNonQualifié = "Employé non qualifié"
    case employéQualifié = "Employé qualifié"
    case ouvrierQualifiéP1P2 = "Ouvrier qualifié (P1,P2)"
    case technicien = "Technicien"
}

// MARK: - Salaire
struct Salaire: Codable {
    let libelle, commentaire: String?
}

enum TypeContrat: String, Codable {
    case cdi = "CDI"
}

enum TypeContratLibelle: String, Codable {
    case contratÀDuréeIndéterminée = "Contrat à durée indéterminée"
}
