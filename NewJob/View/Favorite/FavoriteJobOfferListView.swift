//
//  FavoriteJobOffer.swift
//  NewJob
//
//  Created by Pierre on 07/01/2022.
//

import SwiftUI

struct FavoriteJobOfferListView: View {
    let pm: PersistenceManager
    @ObservedObject var vm = FavoriteJobListViewModel()

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea()
            
            VStack {
                if vm.showProgressView {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(2)
                } else {
                    Form {
                        if vm.jobsWithoutCandidacy.count > 0 {
                            Section(header: Text("Sans Candidatures")) {
                                JobsInList(jobsList: vm.jobsWithoutCandidacy, pm: pm)
                            }
                        }
                        Section(header: Text("Candidatures")) {
                            if vm.jobsWithCandidacy.count > 0 {
                                JobsInList(jobsList: vm.jobsWithCandidacy, pm: pm)
                            } else {
                                Text("Aucune candidature \(vm.searchOptionSelected.lowercased())")
                            }
                        }
                    }
                    .background(Color.white.opacity(0.0))
                    .scrollContentBackground(.hidden)
                }
            }
        }
        .onAppear() {
            vm.pm = pm
            vm.updateJobsList()
        }
        .onChange(of: vm.searchOptionSelected, perform: { _ in
            vm.updateJobsList()
        })
        .navigationBarTitle(Text("Mes annonces"), displayMode:.inline)
        .toolbarBackground(
            Color.white,
            for: .navigationBar
        )
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            Picker("", selection: $vm.searchOptionSelected) {
                ForEach(vm.searchOptions, id: \.self) { option in
                    Button {
                        vm.searchOptionSelected = option
                    } label: {
                        Text("\(option)")
                    }
                }
            }
            .pickerStyle(.menu)
        }
    }
}

struct FavoriteJobOfferListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteJobOfferListView(pm: PersistenceManager())
    }
}
