//
//  ActionsToBeTakenOnFavoriteJob.swift
//  NewJob
//
//  Created by Pierre on 25/04/2022.
//

import SwiftUI

struct ActionsToBeTakenOnFavoriteJobView: View {
    let pm: PersistenceManager
    var job: SelectedJob
    var jobId: String
    @State private var applicationSentOn = Date()
    @State private var showAddRelaunch = false
    @State private var showingAlert = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
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
                            vm.toDoAction(isCreated: change)
                        }
                }
                
                if vm.createCandidacyToggle {
                    Section(header: Text("Candidature")) {
                        PickerDateView(typeOfView: .candidacy, vm: vm)
                        PickerCandidacyMeansView(vm: vm)
                        InformationsCandidacyView(vm: vm)
                    }
                    
                    Section {
                        if vm.favoriteJob?.candidacy?.contact?.count == 0 {
                            Text("Vous n'avez pas de contacts")
                        } else {
                            if vm.favoriteJob!.candidacy?.contact?.count != nil {
                                List {
                                    ForEach(vm.favoriteJob!.candidacy?.contact?.allObjects as! [Contact]) { contact in
                                        NavigationLink(destination: ContactDetailsView(pm: pm, contact: ContactDisplayable(contact: contact))) {
                                            Text(contact.name ?? "Inconnu")
                                            if (contact.functionInCompany != nil) && contact.functionInCompany != "" {
                                                Text(" (\(contact.functionInCompany!))")
                                            }
                                        }
                                    }
                                }
                            }
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
                                AddContactView(pm: pm, jobId: vm.favoriteJob?.id)
                            }
                        }
                    }
                    
                    Section {
                        if vm.favoriteJob?.candidacy?.relaunch?.count == 0 {
                            Text("Vous n'avez pas de relances")
                        } else {
                            if job.candidacy?.relaunch?.count != nil {
                                List {
                                    ForEach(job.candidacy?.relaunch?.allObjects as! [Relaunch]) { relaunch in
                                        NavigationLink(destination: RelaunchDetailsView(pm: pm, relaunch: relaunch)) {
                                            Text("Du \(vm.converteDateToString(date: relaunch.date!))")
                                        }
                                    }
                                }
                            }
                        }
                    } header: {
                        HStack{
                            Text("Relances")
                            Spacer()
                            Button {
                                vm.showingRelaunchSheet.toggle()
                            } label: {
                                Image(systemName: "plus.circle")
                            }
                            .sheet(isPresented: $vm.showingRelaunchSheet) {
                                AddRelaunchView(pm: pm, candidacy: vm.favoriteJob?.candidacy)
                            }
                        }
                    }
                    Section {
                        if vm.favoriteJob?.candidacy?.interview?.count == 0 {
                            Text("Vous n'avez pas de d'entretiens")
                        } else {
                            if job.candidacy?.interview?.count != nil {
                                List {
                                    ForEach(job.candidacy?.interview?.allObjects as! [Interview]) { interview in
                                        NavigationLink(destination: InterviewDetailsView(pm: pm, interview: interview, vm: vm)) {
                                            Text("Du \(vm.converteDateToString(date: interview.date!))")
                                        }
                                    }
                                }
                            }
                        }
                    } header: {
                        HStack{
                            Text("Entretiens")
                            Spacer()
                            Button {
                                vm.showingInterviewSheet.toggle()
                            } label: {
                                Image(systemName: "plus.circle")
                            }
                            .sheet(isPresented: $vm.showingInterviewSheet) {
                                AddInterviewView(pm: pm, candidacy: vm.favoriteJob?.candidacy)
                            }
                        }
                    }
                    
                    Section {
                        Picker("Candidature", selection: $vm.textCandidacyState) {
                            Text("En cours").tag("En cours")
                            Text("Validée").tag("Validée")
                            Text("Rejetée").tag("Rejetée")
                        }
                        .pickerStyle(.menu)
                    } header: {
                        HStack{
                            Text("État de la candidature")
                            Spacer()
                        }
                    }
                    
                }
                
                
            }
            .background(Color(white: 1.0))
            .cornerRadius(12)
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
            .onChange(of: vm.textCandidacyState) { newValue in
                vm.updateCandidacy()
            }
            .onChange(of: vm.showingDestinataireSheet) { value in
                if vm.showingDestinataireSheet == false {
                    vm.fetchContactForThisCandidacy()
                }
            }
        }
        .onAppear() {
            vm.pm = pm
            vm.initFavoriteJob(jobId: job.id!)
            vm.fetchRelaunches()
        }
        .navigationBarTitle(Text(" "), displayMode:.inline)
        .toolbarBackground(
            Color.white,
            for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            Button {
                vm.showingDeleteSheet.toggle()
            } label: {
                Image(systemName: "trash")
                    .foregroundColor(.red)
                    .frame(width: 50, height: 50)
            }
        }
        .alert(isPresented: $vm.showingDeleteSheet) {
            Alert(
                title: Text("Supprimer l'offre ?"),
                primaryButton: .destructive(Text("Supprimer"), action: {
                    vm.removeSelectedJob(jobId: jobId)
                    self.presentationMode.wrappedValue.dismiss()
                }),
                secondaryButton: .default(Text("Annuler"), action: {
                    vm.showingDeleteSheet.toggle()
                })
            )
        }
    }
}

struct ActionsToBeTakenOnFavoriteJob_Previews: PreviewProvider {
    static var previews: some View {
        ActionsToBeTakenOnFavoriteJobView(pm: PersistenceManager(), job: SelectedJob(), jobId: "")
    }
}
