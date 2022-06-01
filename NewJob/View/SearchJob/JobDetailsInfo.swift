//
//  JobDetailsDescription.swift
//  NewJob
//
//  Created by Pierre on 01/04/2022.
//

import SwiftUI

struct JobDetailsInfo: View {
    @State var jobDetailsViewModel: JobDetailsViewModel
    var job: Resultat
//    @State private var
    var body: some View {
        VStack {
        
        }
    }
}

struct JobDetailsDescription_Previews: PreviewProvider {
    static var previews: some View {
        JobDetailsInfo(jobDetailsViewModel: JobDetailsViewModel(), job: Resultat(id: "", intitule: "", resultatDescription: "", dateCreation: "", lieuTravail: LieuTravail(libelle: "", latitude: 0, longitude: 0, codepostal: "", commune: ""), entreprise: Entreprise(nom: "", entrepriseDescription: "", entrepriseAdaptee: false), appellationlibelle: "", salaire: Salaire(libelle: "", commentaire: "", complement1: "", complement2: ""), origineOffre: OrigineOffre(origine: "", urlOrigine: "", partenaires: [Partenaire(nom: "", url: "", logo: "")])))
//        JobDetailsInfo(jobDetailsViewModel: JobDetailsViewModel(), job: Resultat(id: "", intitule: "", resultatDescription: "", dateCreation: "", lieuTravail: LieuTravail(libelle: "", latitude: 0, longitude: 0, codepostal: "", commune: ""), entreprise: Entreprise(nom: "", entrepriseDescription: "", entrepriseAdaptee: false), appellationlibelle: "", salaire: Salaire(libelle: "", commentaire: "", complement1: "", complement2: ""), origineOffre: OrigineOffre(origine: "", urlOrigine: "", partenaires: [Partenaire(from: <#Decoder#>)])))
    }
}
