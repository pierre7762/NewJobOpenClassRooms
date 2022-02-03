//
//  JobDetails.swift
//  NewJob
//
//  Created by Pierre on 28/01/2022.
//

import MapKit
import SwiftUI


struct JobDetails: View {
    @ObservedObject private var jobDetailsViewModel = JobDetailsViewModel()
    var job: Job
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.855045 , longitude: 2.342524), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @State var showAction = false
    @State var font: Font = Font.system(.title)
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                
                
                VStack(alignment: .leading) {
                    ScrollView() {
                        VStack {
                            Text(job.lieuTravail.libelle)
                                .font(.footnote)
                                .padding(.init(top: 10, leading: 40, bottom: 0, trailing: 20))
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
                                                   jobDetailsViewModel.openMapForPlace(coordinates: CLLocationCoordinate2D(latitude: job.lieuTravail.latitude , longitude: job.lieuTravail.longitude))
                                               }),
                                               .cancel()
                                           ]
                                       )
                                   }
                            
                        }
                        Text(job.intitule.capitalized)
                            .padding(.init(top: 10, leading: 20, bottom: 5, trailing: 20))
                            .font(.title2)
                            .foregroundColor(.blue)
                       
                        
                        
                        
                        Divider()
                        
                        Text("Description")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 20))
                        if jobDetailsViewModel.showAllDescription {
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
                                jobDetailsViewModel.modifyShowAllDescription()
                                    }, label: {
                                        if jobDetailsViewModel.showAllDescription {
                                            Label("Reduire", systemImage: "arrow.up.circle")
                                        } else {
                                            Label("Voir tout", systemImage: "arrow.down.circle")
                                        }
                                        
                                    })
                            
                            Spacer()
                        }
                        
//                        Divider()
//
//                        Text("Profil souhaité")
//                            .font(.title3)
//                            .fontWeight(.semibold)
//                            .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 20))
//                        Text("Expérience")
//                            .font(.body)
//                            .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                        
                        
                  
                        
                        
                        
                    }
                    
                }
                .frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.95, alignment: .leading)
                .background(Color(white: 1.0))
                .cornerRadius(12)
                
               
            }
            .navigationBarTitle(Text("Détail"), displayMode:.inline)
            .onAppear {
                mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: job.lieuTravail.latitude , longitude: job.lieuTravail.longitude), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            }
        }
    }
}

struct JobDetails_Previews: PreviewProvider {
   static var job = Job(id: "7553374", intitule: "Comptable support logiciel - Expert produit F/H - Informatique de gestion (H/F)", resultatDescription: "Descriptif du poste:\n\nManpower Conseil Recrutement recherche pour son client, expert sur les sujets de fiscalité, « un Comptable support logiciel » pour intégrer l\'équipe « support pôle Entreprise ».\nVous serez en charge d\'intervenir auprès des clients afin de les guider dans l\'utilisation du logiciel de reporting financier, fiscal et règlementaire.\n\nRattaché directement à la responsable du service Support Entreprise, vous serez amené́ à prendre en charge les activités suivantes :\n \nParamétrage et maintenance des modèles :\n* Aide à l\'élaboration de parties fonctionnelles des logiciels développés par la société en relation avec le service recherche & développement.\n* Maintien des modèles existants\nAssistance des utilisateurs (Clients et collaborateurs) :\n* Assurer un support à l\'utilisation de nos logiciels de reporting fiscal\n* Accompagner nos clients jusqu\'à la résolution du problème\n* Assurer un support auprès de nos consultants et nos distributeurs.\nTest :\n* Tester les nouvelles versions applicatives en déroulant les procédures de tests et faire un suivi des anomalies\n* Tester les nouveaux développements et faire un suivi des anomalies\n* Réaliser la recette des modèles et faire un suivi des anomalies\n* Enrichir les procédures de tests de non-régression (Applicatifs et modèles)\nRédaction des fiches d\'aides et autres supports\n\nProfil recherché:\n\nTitulaire d\'une formation supérieure minimum Bac+2 minimum, en informatique/mathématique, comptabilité, d\'école ingénieurs, d\'école de commerce (avec une option finance, droit, fiscalité), ou un 3ème cycle universitaire de gestion (MSG, MSTCF), vous manifestez un intérêt pour le domaine des logiciels comptable et le contact client.\nVous êtes reconnu pour vos qualités d\'analyse, sens du service et de l\'engagement client (écoute, qualités relationnelles et de communication, diplomatie), votre aptitude à rédiger, et votre sens de la qualité.\nD\'autre part, vous avez des connaissances sur les obligations fiscales et déclaratives des entreprises françaises (TVA, liasses fiscales, CVAE, .). Des connaissances sur la fiscalité Groupe serait un plus.\nVous avez une bonne connaissance globale des Systèmes d\'Informations (architecture, base de données, etc,), et êtes à l\'aise avec les nouvelles technologies et l\'utilisation des ERP ; vous disposez d\'un niveau avancé sur Excel, et idéalement vous avez déjà participer à la mise en place d\'un nouvel ERP avec une équipe projet.\nVous bénéficierez d\'un parcours d\'intégration et d\'une formation à votre arrivée.\n \nSalaire : entre 28 KE et 32 KE sur 12 mois\nStatut : agent de maîtrise au forfait jours avec 11 RTT\nHoraires : 9h - 18h du lundi au jeudi\n               9h - 17h le vendredi\n2 jours de télétravail par semaine ", dateCreation: "2022-01-11T11:02:45.000Z", dateActualisation: "2022-01-11T11:02:45.000Z", lieuTravail: NewJob.LieuTravail(libelle: "76 - BOIS GUILLAUME", latitude: 49.471783, longitude: 1.118326, commune: "76108"), romeCode: "M1810", romeLibelle: "Production et exploitation de systèmes d\'information", appellationlibelle: "Gestionnaire de production informatique", entreprise: NewJob.Entreprise(nom: Optional("Manpower Conseil Recrutement"), entrepriseDescription: Optional("\\nDepuis plus de 60 ans, le réseau de cabinets de recrutement Manpower met son expertise du marché de l\'emploi au service des entreprises clientes et des candidats à l\'embauche.\\nLes 4400 collaborateurs œuvrant au sein de nos cabinets de recrutement vous assistent dans toutes vos démarches de recrutement dans un souci permanent de proximité et de qualité.\\nEn tant que cabinet de recrutement responsable et pour mieux satisfaire les entreprises dans la gestion des ressources hum..."), entrepriseAdaptee: false), typeContrat: NewJob.TypeContrat.cdi, typeContratLibelle: NewJob.TypeContratLibelle.contratÀDuréeIndéterminée, natureContrat: NewJob.NatureContrat.contratTravail, experienceExige: NewJob.ExperienceExige.e, experienceLibelle: NewJob.ExperienceLibelle.expérienceExigéeDe2AnS, salaire: NewJob.Salaire(libelle: nil, commentaire: Optional("28 - 32 k€ brut annuel")), dureeTravailLibelle: nil, dureeTravailLibelleConverti: nil, alternance: false, nombrePostes: 1, accessibleTH: false, qualificationCode: "8", qualificationLibelle: "Agent de maîtrise", origineOffre: NewJob.OrigineOffre(origine: "2", urlOrigine: "https://candidat.pole-emploi.fr/offres/recherche/detail/7553374", partenaires: [NewJob.Partenaire(nom: NewJob.Nom.apec, url: "https://www.apec.fr/candidat/recherche-emploi.html/emploi/detail-offre/167417961W?xtor=AL-406", logo: "https://www.pole-emploi.fr/static/img/partenaires/apec80.png")]), secteurActivite: Optional("78"), secteurActiviteLibelle: Optional("Activités des agences de travail temporaire"))
    
    static var previews: some View {
        JobDetails(job: job )
        
    }
}
