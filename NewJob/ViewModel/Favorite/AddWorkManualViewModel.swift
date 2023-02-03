//
//  AddWorkManualViewModel.swift
//  NewJob
//
//  Created by Pierre on 23/01/2023.
//

import Foundation

class AddWorkManualViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var cityName: String = ""
    @Published var jobLink: String = ""
    @Published var description: String = ""
    @Published var socityName: String = ""
    @Published var salary: String = ""
    
    var pm: PersistenceManager!
    
    func createFavoriteJob() {
        print(title, cityName, jobLink, description)
        let uuid = UUID()
        let job = Resultat(
            id: "\(uuid)",
            intitule: title,
            resultatDescription: description,
            dateCreation: "\(Date.now.description(with: .current))",
            lieuTravail: LieuTravail(libelle: cityName, latitude: nil, longitude: nil, codepostal: nil, commune: cityName),
            entreprise: Entreprise(nom: socityName, entrepriseDescription: nil, entrepriseAdaptee: nil),
            appellationlibelle: "",
            salaire: Salaire(libelle: salary, commentaire: nil, complement1: nil, complement2:nil),
            origineOffre: OrigineOffre(origine: "", urlOrigine: jobLink, partenaires: [Partenaire(nom: "", url: "", logo: "")])
        )
        pm.createSelectedJob(job: job)
    }
}
