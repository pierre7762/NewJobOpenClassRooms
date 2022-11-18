//
//  RelaunchContact.swift
//  NewJob
//
//  Created by Pierre on 07/01/2022.
//

import SwiftUI

struct ActionToBeTakenView: View {
    @ObservedObject var vm: ActionToBeTakenViewModel = ActionToBeTakenViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint,.green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea()
            
            List {
                FollowingActionsToBeTaken(headerTitle: "Suivi d'entretien", object: vm.interviewsToBeRelaunch, emptyText: "Aucun de suivi d'entretiens à effectuer")
                FollowingActionsToBeTaken(headerTitle: "Suivi de relance", object: vm.relaunchToBeRelanch, emptyText: "Aucun suivi de relance à effectuer")
                FollowingActionsToBeTaken(headerTitle: "Relancer une candidature", object: vm.candidaciesToBeRelanch, emptyText: "Aucun de suivi de candidatures à effectuer")
            }
            .background(Color.white.opacity(0.0))
            .scrollContentBackground(.hidden)
            
        }
        .navigationBarTitle(Text("Actions à Réaliser"), displayMode:.inline)
        .toolbarBackground(
            Color.white,
            for: .navigationBar
        )
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear() {
            vm.getCandidacyToBeRelaunch(numberOfDayFrom: 6)
        }

    }
}

struct RelaunchContact_Previews: PreviewProvider {
    static var previews: some View {
        ActionToBeTakenView()
    }
}
