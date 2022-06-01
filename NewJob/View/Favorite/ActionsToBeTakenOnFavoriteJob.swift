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
    @ObservedObject var viewModel: ActionsToBeTakenOnFavoriteJobViewModel = ActionsToBeTakenOnFavoriteJobViewModel()
    
    
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }()

    
    var body: some View {
        GeometryReader { geometry in
            ZStack {

                LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)


                Form {
                        Section()  {
                            Toggle("J'ai postulé", isOn: $viewModel.createCandidacyToggle)
                                .onChange(of: viewModel.createCandidacyToggle) { change in
                                    viewModel.createRemoveCandidady(isCreated: change, job: job)
                                    viewModel.favoriteJob?.candidacy?.forEach({ cand in
                                        print(cand)
                                    })
                                                                  }
                        }
                    

                    if viewModel.createCandidacyToggle {
                        Section(header: Text("Candidature")) {
                            DatePicker(selection: $applicationSentOn, in: ...Date(), displayedComponents: .date) {
                                            Text("Envoyée le :")
                                        }
                            .onChange(of: applicationSentOn) { newValue in
//                                print("newValue : ", newValue)
//                                viewModel.favoriteJob?.candidacy!.candidacyDate[0] = newValue
//                                viewModel.favoriteJob.candidacy.updateCandidacyDate(newValue)
//                                viewModel.memoryManager.saveData()
//                                print("candidacy date : ", viewModel.favoriteJob.candidacy!.candidacyDate)
//                                print(newValue)
                            }
                            HStack {
                                Text("Moyen utilisé :")
                                Spacer()
                                Picker("contactBy", selection: $test) {
                                    Text("Non précisé").tag("Non précisé")
                                    Text("Téléphone").tag("Téléphone")
                                    Text("Mail").tag("Mail")
                                    Text("Courrier").tag("Courrier")
                                    Text("Site internet").tag("Site internet")
                                }
                                .pickerStyle(.menu)
//                                        .onChange(of: newSearchJob.search.experience) { newValue in
//                                            newSearchJob.search.experience = newValue
//                                        }
                            }
                            TextField("Destinataire", text: $destinataire)
            

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
        }

        
    }
}

struct ActionsToBeTakenOnFavoriteJob_Previews: PreviewProvider {
    static var previews: some View {
        ActionsToBeTakenOnFavoriteJob(job: SelectedJob())
    }
}
