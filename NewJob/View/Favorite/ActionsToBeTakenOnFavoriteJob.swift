//
//  ActionsToBeTakenOnFavoriteJob.swift
//  NewJob
//
//  Created by Pierre on 25/04/2022.
//

import SwiftUI

struct ActionsToBeTakenOnFavoriteJob: View {
    var job: SelectedJob
    var jobId: String
    @State private var applicationSentOn = Date()
    @State private var showAddRelaunch = false
    @State private var destinataire = ""
    @State private var test: String = ""
    @ObservedObject var vm: ActionsToBeTakenOnFavoriteJobViewModel = ActionsToBeTakenOnFavoriteJobViewModel()
    
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }()

    var body: some View {
        VStack {
            Form {
                Section()  {
                    Toggle("J'ai postulé", isOn: $vm.createCandidacyToggle)
                        .onChange(of: vm.createCandidacyToggle) { change in
                            vm.createRemoveCandidady(isCreated: change)
                        }
                }
                
                if vm.createCandidacyToggle {
                    Section(header: Text("Candidature")) {
                        PickerDateView(vm: vm)
                        PickerCandidacyMeansView(vm: vm)
                        InformationsCandidacyView(vm: vm)
                    }
                    
                    Section {
                        if vm.favoriteJob?.candidacy?.contact?.count == 0 {
                            Text("Vous n'avez pas de contacts")
                        } else {
                            ContactCandidacyRow(jobId: jobId,job: job, vm: vm)
                        }
                    } header: {
                        HStack{
                            Text("Contacts")
                            Spacer()
                            Button {
                                vm.showingDestinataireSheet.toggle()
                            } label: {
                                Image(systemName: "plus.circle")
                            }
                            .sheet(isPresented: $vm.showingDestinataireSheet) {
                                AddContactView(jobId: vm.favoriteJob?.id)
                            }
                        }
                    }
                    
                    Section {
                        if vm.favoriteJob?.candidacy?.relaunch?.count == 0 {
                            Text("Vous n'avez pas de relances")
                        }
                    } header: {
                        HStack{
                            Text("Relances")
                            Spacer()
                            Button {
                                print("todo")
                            } label: {
                                Image(systemName: "plus.circle")
                            }
                        }
                    }
                }
                
                
            }
            .cornerRadius(12)
            .onChange(of: vm.createDateCandidacy) { newValue in
                vm.updateCandidacy()
            }
            .onChange(of: vm.means) { newValue in
                vm.updateCandidacy()
            }
            .onChange(of: vm.comment) { newValue in
                vm.updateCandidacy()
            }
        }
        .onAppear() {
            vm.initFavoriteJob(job: job)
        }
        .navigationBarTitle(Text(" "), displayMode:.inline)
        .toolbarBackground(
            Color.white,
            for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct ActionsToBeTakenOnFavoriteJob_Previews: PreviewProvider {
    static var previews: some View {
        ActionsToBeTakenOnFavoriteJob(job: SelectedJob(), jobId: "")
    }
}
