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
//    @State private var showingDestinataireSheet = false
    @ObservedObject var viewModel: ActionsToBeTakenOnFavoriteJobViewModel = ActionsToBeTakenOnFavoriteJobViewModel()
    
    
    
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }()

    
    var body: some View {
        VStack {
            Form {
                Section()  {
                    Toggle("J'ai postulé", isOn: $viewModel.createCandidacyToggle)
                        .onChange(of: viewModel.createCandidacyToggle) { change in
                            viewModel.createRemoveCandidady(isCreated: change)
                        }
                    }
                
                    if viewModel.createCandidacyToggle {
                        Section(header: Text("Candidature")) {
                            PickerDateView(vm: viewModel)
                            PickerCandidacyMeansView(vm: viewModel)
                            ContactCandidacyRow(jobId: jobId,job: job, vm: viewModel)
                            InformationsCandidacyView(vm: viewModel)
                        }
                    }
                }
                .cornerRadius(12)
                .onChange(of: viewModel.createDateCandidacy) { newValue in
//                    if viewModel.favoriteJobIsInit {
//                        viewModel.updateCandidacy()
//                    }
                    viewModel.updateCandidacy()
                }
                .onChange(of: viewModel.means) { newValue in
                    viewModel.updateCandidacy()
                }
                .onChange(of: viewModel.comment) { newValue in
                    viewModel.updateCandidacy()
                }
            }
            .onAppear() {
                viewModel.initFavoriteJob(job: job)
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
