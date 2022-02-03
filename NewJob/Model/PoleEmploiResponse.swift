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


// MARK: - PoleEmploiResponse
struct PoleEmploiResponse: Decodable {
    let resultats: [Job]
    let filtresPossibles: [FiltresPossible]
}

// MARK: - FiltresPossible
struct FiltresPossible: Decodable {
    let filtre: String
    let agregation: [Agregation]
}

// MARK: - Agregation
struct Agregation: Decodable {
    let valeurPossible: String
    let nbResultats: Int
}

// MARK: - Resultat
struct Job: Decodable, Identifiable {
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
    let dureeTravailLibelle, dureeTravailLibelleConverti: String?
    let alternance: Bool
    let nombrePostes: Int
    let accessibleTH: Bool
    let qualificationCode, qualificationLibelle: String
    let origineOffre: OrigineOffre
    let secteurActivite, secteurActiviteLibelle: String?

    enum CodingKeys: String, CodingKey {
        case id, intitule
        case resultatDescription = "description"
        case dateCreation, dateActualisation, lieuTravail, romeCode, romeLibelle, appellationlibelle, entreprise, typeContrat, typeContratLibelle, natureContrat, experienceExige, experienceLibelle, salaire, dureeTravailLibelle, dureeTravailLibelleConverti, alternance, nombrePostes, accessibleTH, qualificationCode, qualificationLibelle, origineOffre, secteurActivite, secteurActiviteLibelle
    }
}

// MARK: - Entreprise
struct Entreprise: Decodable {
    let nom, entrepriseDescription: String?
    let entrepriseAdaptee: Bool

    enum CodingKeys: String, CodingKey {
        case nom
        case entrepriseDescription = "description"
        case entrepriseAdaptee
    }
}

enum ExperienceExige: String, Decodable {
    case d = "D"
    case e = "E"
}

enum ExperienceLibelle: String, Decodable {
    case débutantAccepté = "Débutant accepté"
    case expérienceExigée = "Expérience exigée"
    case expérienceExigéeDe1AnS = "Expérience exigée de 1 An(s)"
    case expérienceExigéeDe2AnS = "Expérience exigée de 2 An(s)"
}

// MARK: - LieuTravail
struct LieuTravail: Decodable {
    let libelle: String
    let latitude, longitude: Double
    let commune: String
}

enum NatureContrat: String, Decodable {
    case contratTravail = "Contrat travail"
}

// MARK: - OrigineOffre
struct OrigineOffre: Decodable {
    let origine: String
    let urlOrigine: String
    let partenaires: [Partenaire]
}

// MARK: - Partenaire
struct Partenaire: Decodable {
    let nom: Nom
    let url: String
    let logo: String
}

enum Nom: String, Decodable {
    case apec = "APEC"
    case beetween = "BEETWEEN"
    case jobijoba = "JOBIJOBA"
}

// MARK: - Salaire
struct Salaire: Decodable {
    let libelle, commentaire: String?
}

enum TypeContrat: String, Decodable {
    case cdd = "CDD"
    case cdi = "CDI"
}

enum TypeContratLibelle: String, Decodable {
    case contratÀDuréeDéterminée4Mois = "Contrat à durée déterminée - 4 Mois"
    case contratÀDuréeDéterminée6Mois = "Contrat à durée déterminée - 6 Mois"
    case contratÀDuréeIndéterminée = "Contrat à durée indéterminée"
}
