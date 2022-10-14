//
//  JobDetails.swift
//  NewJob
//
//  Created by Pierre on 28/01/2022.
//

import MapKit
import SwiftUI
import WebKit


struct JobDetails: View {
    @ObservedObject private var viewModel = JobDetailsViewModel()
    var job: Resultat
    var index: Int
    @State private var coordinate = CLLocationCoordinate2D(latitude: 48.855045, longitude: 2.342524)
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.855045 , longitude: 2.342524), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @State var showAction = false
    @State var font: Font = Font.system(.title)
    @State private var showWebView = false
//    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {

                LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)


                VStack(alignment: .leading) {
                    ScrollView() {
                        VStack {
                            Text(job.lieuTravail.libelle ?? "")
                                .font(.footnote)
                                .padding(.init(top: 10, leading: 40, bottom: 0, trailing: 20))
                            if job.lieuTravail.latitude != nil && job.lieuTravail.longitude != nil {
                                Button(action: {
                                           showAction.toggle()
                                       }, label: {
                                           Map(coordinateRegion: $mapRegion)
                                               .frame(width: geometry.size.width * 0.7, height: geometry.size.width * 0.3, alignment: .center)
                                               .cornerRadius(12)
                                       }).actionSheet(isPresented: $showAction) {
                                           ActionSheet(
                                               title: Text("Voulez-vous obtenir un itinéraire ?"),
                                               buttons: [
                                                   .default(Text("Allons-y !"), action: {
                                                       viewModel.openMapForPlace(coordinates: CLLocationCoordinate2D(latitude: job.lieuTravail.latitude! , longitude: job.lieuTravail.longitude!), name: job.entreprise.nom ?? "Localisation du poste")
                                                   }),
                                                   .cancel()
                                               ]
                                           )
                                       }
                            } else {
                                Text("Erreur coordonnées")
                            }
                        }
                        Text(job.intitule.capitalized)
                            .padding(.init(top: 10, leading: 20, bottom: 5, trailing: 20))
                            .font(.title2)
                            .foregroundColor(.blue)

                        Divider()

                        Button {
                            showWebView.toggle()
                        } label: {
                            Text("Lien vers l'annonce")
                                .underline()
                        }
                        .sheet(isPresented: $showWebView) {
                            WebView(url: URL(string: job.origineOffre.urlOrigine)!)
                        }
                        
                        JobDetailsInfo(jobDetailsViewModel: viewModel, job: job)
                        
                        Text("Description")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 20))
                        if viewModel.showAllDescription {
                            ScrollView() {


                                Text(job.resultatDescription)
                                    .font(.body)
                                    .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 20))


                            }
                        } else {
                            VStack {
                                Text(job.resultatDescription)
                                    .font(.body)
                                    .padding(.init(top: 10, leading: 20, bottom: 5, trailing: 20))
                                    .lineLimit(10)
                            }

                        }
                        HStack() {
                            Spacer()
                            Button(action: {
                                viewModel.modifyShowAllDescription()
                                    }, label: {
                                        if viewModel.showAllDescription {
                                            Label("Reduire", systemImage: "arrow.up.circle")
                                        } else {
                                            Label("Voir tout", systemImage: "arrow.down.circle")
                                        }

                                    })

                            Spacer()
                        }
                    }

                }
                .frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.95, alignment: .leading)
                .background(Color(white: 1.0))
                .cornerRadius(12)


            }
            .navigationBarTitle(Text("Détail"), displayMode:.inline)
            .toolbar{
                ToolbarItem(placement: .automatic) {
                    Button {
                        if viewModel.isFavorite {
                            viewModel.deleteThisFavorite(index: index)
                        } else {
                            viewModel.prepareSaveJob(job: job)
                        }
                    } label: {
                        if viewModel.isFavorite {
                            Image(systemName: "heart.fill")
                        } else {
                            Image(systemName: "heart")
                        }
                    }
                            }
            }
            .onAppear {
                viewModel.checkIfIsFavorite(job: job)
                mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: job.lieuTravail.latitude ?? 48.855045 , longitude: job.lieuTravail.longitude ?? 2.342524), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
               
            }
        }
    }
}

struct JobDetails_Previews: PreviewProvider {
        
    static var job = Resultat(
        id: "8815294",
        intitule: "Maintenance informatique et bureautique",
        resultatDescription: "POSTE : Technicien Support Logiciel H/F\nDESCRIPTION : Depuis 50 ans, nous sommes animés par la conviction que les ingénieurs, par leur audace, leur expertise et leur capacité à faire bouger les lignes sont les architectes du monde de demain.\nTous les jours, nos 7 000 collaborateurs innovent au contact de leurs clients et contribuent à l'accélération de la transition énergétique partout dans le monde. Ils accompagnent les plus grands projets de l'ingénierie mondiale dans les domaines de l'énergie, du digital et des transports.\nGroupe international en forte croissance, nous sommes présents dans 13 pays (Europe, Moyen-Orient, Asie, Afrique).\n\nL'arrivée de la digitalisation dans les infrastructures industrielles a créé de nouveaux besoins et de nouvelles opportunités. Le monde de l'ingénierie est en pleine mutation et l'avancée de la digitalisation s'appuie notamment sur une quantité massive de données exploitables, au service de la performance des installations.\n\nAu sein de son pôle Digital, Assystem accompagne ses clients sur des prestations de conseil et d'intégration de solutions, en s'appuyant sur ses expertises d'intelligence artificielle, de développement applicatif au service des métiers, d'ingénierie système et outils numériques associés.\n\nDans le cadre du développement de notre bureau d'étude à Petit Quevilly, nous recherchons un(e) technicien(ne) spécialisé(e) dans le support logiciel.\nSous la responsabilité d'un chef de projet et en lien avec le service DSI groupe, vous intervenez sur le traitement d'anomalies mais également sur des évolutions d'un ensemble d'applications métier.\nA ce titre, vous êtes en charge de :\nTraiter les incidents remontés par le support niveau 1 sur les logiciels métiers\nFaire un état des lieux, apporter des corrections, des adaptations, mesurer le fonctionnement et mettre à jour les documentations de ces logiciels métiers\nAnalyser et préconiser des solutions techniques\nRecommander et définir l'architecture technique en cohérence avec les préconisations de la DSI\nParticiper à des projets de développement lors de l'intégration de nouvelles fonctionnalités ou la mise à disposition de nouvelles applications\nPROFIL : De formation Bac +2 en Informatique, vous disposez d'une expérience de plus de 2 ans dans le support logiciel. Vous faites preuve d'un esprit de synthèse et d'analyse. Capable de prendre des initiatives, vous êtes autonome et force de proposition.\nUne expérience dans les outils BPM et la programmation Web serait appréciée, tout comme des connaissances en système d'exploitation (Windows, Linux) et en base de données. ",
        dateCreation: "2022-02-03T22:15:16.000Z",
//        dateActualisation: "2022-02-10T22:24:29.000Z",
        lieuTravail: LieuTravail(
            libelle: "76 - ROUEN",
            latitude: 49.441346,
            longitude: 1.092567,
            codepostal: "76000",
            commune: "76540"
        ),
//        romeCode: "I1401",
//        romeLibelle: "Maintenance informatique et bureautique",
        entreprise: Entreprise(
            nom: "nom de l'entreprise",
            entrepriseDescription: "",
            entrepriseAdaptee: false
        ),
        appellationlibelle: "Technicien(ne) d'assistance à la clientèle en informatique",
//        typeContrat: "cdi",
//        typeContratLibelle: "contratÀDuréeIndéterminée",
//        natureContrat: "contratTravail",
//        experienceExige: "d",
//        experienceLibelle: "débutantAccepté",
        salaire: Salaire(
            libelle: "",
            commentaire: "",
            complement1: "",
            complement2: ""
        ),
//        alternance: false,
//        nombrePostes: 1,
//        accessibleTH: true,
//        qualificationCode: "7",
//        qualificationLibelle: "technicien",
//        secteurActivite: "71",
//        secteurActiviteLibelle: "Ingénierie, études techniques",
        origineOffre: OrigineOffre(
            origine: "2",
            urlOrigine: "https://candidat.pole-emploi.fr/offres/recherche/detail/8815294",
            partenaires: [
                Partenaire(
                    nom: "careerbuilder",
                    url: "https://www.lesjeudis.com/jobs/J3W7MS6BQ2NNYFP05D7?siteid=int_FRpoleemploi&utm_source=pole_emploi&utm_medium=aggregator&utm_campaign=organic",
                    logo: "https://www.pole-emploi.fr/static/img/partenaires/careerbuilder80.png"
                )
//                Partenaire(
//                    from: Decoder as! Decoder
//                )
            ]
        )
//        dureeTravailLibelle: "",
//        dureeTravailLibelleConverti: ""
    )
    
    static var previews: some View {
        JobDetails(job: job, index: 0 )
        
    }
}
