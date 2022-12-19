//
//  FakePoleEmploiResult.swift
//  NewJobTests
//
//  Created by Pierre on 09/12/2022.
//

import Foundation
@testable import NewJob

struct FakePoleEmploiResult {
    func getFakePoleEmploiResultJobs() -> [Resultat] {
        var resultats: [Resultat] = []
        
        let resultOne = Resultat(
            id: "4015584",
            intitule: "Chauffeur-livreur / Chauffeuse-livreuse (H/F)",
            resultatDescription: "ACTUA ARRAS recrute pour l'un de ses clients, société spécialisée dans la livraison de produits frais pour les restaurants et boucherie, Un chauffeur VL H/F\n\nAu départ du dépôt vous chargez votre camion des commandes attribuées, vous livrez les magasins, les boucheries et vérifier le bon de livraison avec le client.\nVous êtes garant de la bonne livraison des produits et de la température Frigo de votre camion.\n\nPermis B +2 ans obligatoire, expérience en livraisons obligatoire d'au moins 6 mois (si possible en produits frais ou surgelés).\n\nMission à compter du 05/12/2022 jusque fin décembre minimum, horaire 03h-13h du mardi au vendredi\n35h/ semaine\n\n11.43 EUR/h + prime panier + heures de nuit\n\n  \n Permis B +2 ans\nUne première expérience de chauffeur est exigée (hors frigo ok).\nBon contact clients",
            dateCreation: "2022-11-25T03:10:24.000Z",
            lieuTravail: LieuTravail(
                libelle: "62 - LIEVIN",
                latitude: 50.424192,
                longitude: 2.769683,
                codepostal: "62800",
                commune: "62510"
            ),
            entreprise: Entreprise(
                nom: "ACTUA ARRAS",
                entrepriseDescription: nil,
                entrepriseAdaptee: false
            ),
            appellationlibelle: "Chauffeur-livreur / Chauffeuse-livreuse",
            salaire: Salaire(
                libelle: "Annuel de 15000,00 Euros à 20000,00 Euros",
                commentaire: "panier jour + heures de nuit",
                complement1: nil,
                complement2: nil
            ),
            origineOffre: OrigineOffre(
                origine: "2",
                urlOrigine: "https://candidat.pole-emploi.fr/offres/recherche/detail/4015584",
                partenaires: [
                    Partenaire(
                        nom: "TALENTPLUG",
                        url: "http://app.mytalentplug.com/description-offre.aspx?ojid=BV6mpbG4FHZrFoyLB1wW4g==",
                        logo: "https://www.pole-emploi.fr/static/img/partenaires/talentplug80.png"
                    )
                ]
            )
        )
        
        let resultTwo = Resultat(
            id: "2912559",
            intitule: "Conducteur livreur / Conductrice livreuse poids lourds (H/F)",
            resultatDescription: "L'opérateur / opératrice d'assainissement entretient et nettoie les canalisations d'assainissement et les ouvrages qui s'y rapportent sous la voirie et dans les stations de relèvement et de pompage. Il/Elle intervient chez des particuliers et des industriels, dans les immeubles et sur des sites de l'espace public. \n  \n \nNous recherchons une personne motivé, autonome, qui procède le Permis C et ADR.",
            dateCreation: "2022-11-02T19:50:35.000Z",
            lieuTravail: LieuTravail(
                libelle: "02 - ST QUENTIN",
                latitude: 49.847398,
                longitude: 3.287761,
                codepostal: "02100",
                commune: "02691"
            ),
            entreprise: Entreprise(
                nom: "CRIT SAINT QUENTIN",
                entrepriseDescription: nil,
                entrepriseAdaptee: false
            ),
            appellationlibelle: "Conducteur livreur / Conductrice livreuse poids lourds",
            salaire: Salaire(
                libelle: "Horaire de 11,07 Euros à 11,07 Euros",
                commentaire: "...",
                complement1: nil,
                complement2: nil
            ),
            origineOffre: OrigineOffre(
                origine: "2",
                urlOrigine: "https://candidat.pole-emploi.fr/offres/recherche/detail/2912559",
                partenaires: [
                    Partenaire(
                        nom: "TALENTPLUG",
                        url: "http://app.mytalentplug.com/description-offre.aspx?ojid=lOA2EVMsmUJojozYmNPeCg==",
                        logo: "https://www.pole-emploi.fr/static/img/partenaires/talentplug80.png"
                    )
                ]
            )
        )
        
        resultats.append(resultOne)
        resultats.append(resultTwo)
        
        return resultats
    }
    
    func getFakeFiltresPossibles() -> [FiltresPossible]{
        let filtresPossible: [FiltresPossible] = [
            FiltresPossible(
                filtre: "typeContrat",
                agregation: [
                    Agregation(
                        valeurPossible: "MIS",
                        nbResultats: 2
                    )
                ]
            ),
            FiltresPossible(
                filtre: "experience",
                agregation: [
                    Agregation(
                        valeurPossible: "2",
                        nbResultats: 2
                    )
                ]
            ),
            FiltresPossible(
                filtre: "qualification",
                agregation: [
                    Agregation(
                        valeurPossible: "0",
                        nbResultats: 2
                    )
                ]
            ),
            FiltresPossible(
                filtre: "natureContrat",
                agregation: [
                    Agregation(
                        valeurPossible: "E1",
                        nbResultats: 2
                    )
                ]
            ),
        ]
        return filtresPossible
    }
}
