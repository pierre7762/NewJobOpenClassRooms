//
//  ActionsToBeTakenOnFavoriteJob.swift
//  NewJob
//
//  Created by Pierre on 25/04/2022.
//

import SwiftUI

struct ActionsToBeTakenOnFavoriteJob: View {
    var job: SelectedJob
//    @State var applicationIsSent: Bool = false
    @State private var applicationSentOn = Date()
    @State private var showAddRelaunch = false
    @State private var test = false
    @State private var destinataire = ""
//    @State private var showingDestinataireSheet = false
    @ObservedObject var viewModel: ActionsToBeTakenOnFavoriteJobViewModel = ActionsToBeTakenOnFavoriteJobViewModel()
    
    
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }()

    
    var body: some View {
        let _ = print(viewModel.favoriteJob?.candidacy)
        GeometryReader { geometry in
            ZStack {

                LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)


                Form {
                        Section()  {
                            Toggle("J'ai postulé", isOn: $viewModel.createCandidacyToggle)
                                .onChange(of: viewModel.createCandidacyToggle) { change in
//                                    viewModel.createRemoveCandidady(isCreated: change, job: job)
//                                    viewModel.favoriteJob?.candidacy?.forEach({ cand in
//                                        print(cand)
//                                    })
                                                                  }
                        }
                    

                    if viewModel.createCandidacyToggle {
                        Section(header: Text("Candidature")) {
                            DatePicker(selection: $viewModel.createDateCandidacy, in: ...Date(), displayedComponents: .date) {
                                            Text("Envoyée le :")
                                        }
                            .onChange(of: applicationSentOn) { newValue in
//                                viewModel.updateCandidacyDate(newDate: newValue)
                                viewModel.createDateCandidacy = newValue
//
                            }
                            HStack {
                                Text("Moyen utilisé :")
                                Spacer()
                                Picker("contactBy", selection: $viewModel.means) {
                                    Text("Non précisé").tag("Non précisé")
                                    Text("Téléphone").tag("Téléphone")
                                    Text("Mail").tag("Mail")
                                    Text("Courrier").tag("Courrier")
                                    Text("Site internet").tag("Site internet")
                                }
                                .pickerStyle(.menu)
                                
                                
                            }
                            VStack {
                                HStack{
                                    Text("Destinataire :")
                                    if job.candidacy?.contact?.count == 0 {
                                        Text("empty")
                                        Button {
                                            print("Button was tapped")
                                            viewModel.showingDestinataireSheet.toggle()
                                        } label: {
                                            Image(systemName: "person.crop.circle.fill.badge.plus")
                                                .font(.system(size: 30))
                                        }
                                        .cornerRadius(12)
                                    } else {
                                        Text("\((job.candidacy?.contact?.allObjects as! [Contact])[0].name ?? "")")
                                       
                                    }
                                    
                                    Spacer()
                                }
                                .sheet(isPresented: $viewModel.showingDestinataireSheet) {
                                    AddContactView()
                                }
                                
                            }
                            
                            HStack {
                                Spacer()
                                Button {
                                    print("Button was tapped")
                                    viewModel.createCandidacy()
                                } label: {
                                    Text("Enregistrer")
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(.green)
                                }
                                .cornerRadius(12)
                                Spacer()
                            }
                            .padding()
            
                        }
                        
//                        Section(header: Text("Relances")) {
//                            if showAddRelaunch {
//                                VStack {
//                                    DatePicker(selection: $applicationSentOn, in: ...Date(), displayedComponents: .date) {
//                                                    Text("Effectuée le :")
//                                    }
//                                    HStack {
//                                        Text("Moyen utilisé :")
//                                        Spacer()
//                                        Picker("contactBy", selection: $test) {
//                                            Text("Non précisé").tag("Non précisé")
//                                            Text("Téléphone").tag("Téléphone")
//                                            Text("Mail").tag("Mail")
//                                            Text("Courrier").tag("Courrier")
//                                        }
//                                        .pickerStyle(.menu)
////                                        .onChange(of: newSearchJob.search.experience) { newValue in
////                                            newSearchJob.search.experience = newValue
////                                        }
//                                    }
//                                    TextField("Destinataire", text: $destinataire)
//
//                                }
//                            } else {
//                                Button {
//                                    showAddRelaunch.toggle()
//                                } label: {
//                                    Text("Ajouter")
//                                }
//                            }
//
//
//
//                            List {
//
//                            }
//                        }
                    }
                    
                }

            }
        }
        .onAppear() {
            viewModel.favoriteJob = job
//            viewModel.candidacyIsCreated()
//            testF()
//            print("selectedJob : ", job)
//            print("selectedJob.candidacy : ", job.candidacy?.candidacyDate)
            if job.candidacy != nil {
                viewModel.createCandidacyToggle = true
            }
            viewModel.createDateCandidacy = job.candidacy?.candidacyDate ?? Date()
            viewModel.means = job.candidacy?.candidacyMeans ?? ""
        }

        
    }
}

struct ActionsToBeTakenOnFavoriteJob_Previews: PreviewProvider {
    static var previews: some View {
        ActionsToBeTakenOnFavoriteJob(job: SelectedJob())
    }
}
