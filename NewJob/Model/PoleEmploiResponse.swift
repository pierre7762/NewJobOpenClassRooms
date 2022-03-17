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


//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let poleEmploiResponse = try? newJSONDecoder().decode(PoleEmploiResponse.self, from: jsonData)
//
//// MARK: - PoleEmploiResponse
//struct PoleEmploiResponse: Codable {
//    let resultats: [Resultat]
//    let filtresPossibles: [FiltresPossible]
//}
//
//// MARK: - FiltresPossible
//struct FiltresPossible: Codable {
//    let filtre: String?
//    let agregation: [Agregation]?
//}
//
//// MARK: - Agregation
//struct Agregation: Codable {
//    let valeurPossible: String?
//    let nbResultats: Int?
//}
//
//// MARK: - Resultat
//struct Resultat: Codable, Identifiable {
//    let id, intitule, resultatDescription, dateCreation: String
//    let dateActualisation: String?
//    let lieuTravail: LieuTravail?
//    let romeCode, romeLibelle, appellationlibelle: String?
//    let entreprise: Entreprise?
////    let typeContrat: TypeContrat?
//    let typeContrat: String?
////    let typeContratLibelle: TypeContratLibelle?
//    let typeContratLibelle: String?
////    let natureContrat: NatureContrat?
//    let natureContrat: String?
////    let experienceExige: ExperienceExige?
//    let experienceExige: String?
//    let experienceLibelle: String?
////    let experienceCommentaire: String?
//    let salaire: Salaire?
////    let langues: Langues?
////    let permis: Permis?
////    let outilsBureautiques: String?
//    let alternance: Bool?
//    let nombrePostes: Int?
//    let accessibleTH: Bool?
//    let qualificationCode: String?
////    let qualificationLibelle: QualificationLibelle
//    let qualificationLibelle: String?
//    let secteurActivite, secteurActiviteLibelle: String?
//    let origineOffre: OrigineOffre?
////    let offresManqueCandidats: Bool?
//
//
//    let dureeTravailLibelle, dureeTravailLibelleConverti: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, intitule
//        case resultatDescription = "description"
//        case dateCreation, dateActualisation, lieuTravail, romeCode, romeLibelle, appellationlibelle, entreprise, typeContrat, typeContratLibelle, natureContrat, experienceExige, experienceLibelle, salaire, alternance, nombrePostes, accessibleTH, qualificationCode, qualificationLibelle, secteurActivite, secteurActiviteLibelle, origineOffre, dureeTravailLibelle, dureeTravailLibelleConverti
//    }
//}
//
//// MARK: - Entreprise
//struct Entreprise: Codable {
//    let entrepriseDescription: String?
////    let logo: String?
////    let url: String?
//    let entrepriseAdaptee: Bool?
//    let nom: String?
//
//
//    enum CodingKeys: String, CodingKey {
//        case entrepriseDescription = "description"
//        case entrepriseAdaptee, nom
//    }
//}
//
////enum ExperienceExige: String, Codable {
////    case d = "D"
////    case e = "E"
////    case s = "S"
////}
//
////enum ExperienceLibelle: String, Codable {
////    case débutantAccepté = "Débutant accepté"
////    case expérienceExigée = "Expérience exigée"
////    case expérienceExigée1 = "Expérience exigée (1)"
////    case expérienceExigéeDe12Mois = "Expérience exigée de 12 Mois"
////    case expérienceExigéeDe1AnS = "Expérience exigée de 1 An(s)"
////    case expérienceExigéeDe1Mois = "Expérience exigée de 1 Mois"
////    case expérienceExigéeDe2AnS = "Expérience exigée de 2 An(s)"
////    case expérienceExigéeDe3AnS = "Expérience exigée de 3 An(s)"
////    case expérienceExigéeDe5AnS = "Expérience exigée de 5 An(s)"
////    case expérienceExigéeDe60Mois = "Expérience exigée de 60 Mois"
////    case expérienceExigéeDe6AnS = "Expérience exigée de 6 An(s)"
////}
//
//// MARK: - LieuTravail
//struct LieuTravail: Codable {
//    let libelle: String?
//    let latitude, longitude: Double?
//    let codepostal: String?
//    let commune: String?
//}
//
////enum NatureContrat: String, Codable {
////    case contratTravail = "Contrat travail"
////}
//
//// MARK: - OrigineOffre
//struct OrigineOffre: Codable {
//    let origine: Int?
//    let urlOrigine: String?
//    let partenaires: [Partenaire?]
//}
//
//// MARK: - Partenaire
//struct Partenaire: Codable {
////    let nom: Nom
//    let nom: String?
//    let url: String?
//    let logo: String?
//}
//
////enum Nom: String, Codable {
////    case apec = "APEC"
////    case beetween = "BEETWEEN"
////    case careerbuilder = "CAREERBUILDER"
////    case jobijoba = "JOBIJOBA"
////    case meteojob = "METEOJOB"
////}
//
////enum QualificationLibelle: String, Codable {
////    case agentDeMaîtrise = "Agent de maîtrise"
////    case employéNonQualifié = "Employé non qualifié"
////    case employéQualifié = "Employé qualifié"
////    case ouvrierQualifiéP1P2 = "Ouvrier qualifié (P1,P2)"
////    case technicien = "Technicien"
////}
//
//// MARK: - Salaire
//struct Salaire: Codable {
//    let libelle, commentaire, complement1, complement2: String?
//}
//
////enum TypeContrat: String, Codable {
////    case cdi = "CDI"
////}
//
////enum TypeContratLibelle: String, Codable {
////    case contratÀDuréeIndéterminée = "Contrat à durée indéterminée"
////}
//
//// MARK: - Formations
//struct Formations: Decodable {
//    let domaineLibelle: String?
//    let niveauLibelle: String?
//    let commentaire: String?
////    let exigence: Exigence
//    let exigence: String?
//}
//
////enum Exigence: String, Codable {
////    case e = "Exigé"
////    case s = "Souhaité"
////}
//
//// MARK: - Langues
//struct Langues: Decodable {
//    let libelle: String?
////    let exigence: Exigence
//    let exigence: String?
//}
//
//// MARK: - Permis
//struct Permis: Decodable {
//    let libelle: String?
////    let exigence: Exigence
//    let exigence: String?
//}
//


import Foundation

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
