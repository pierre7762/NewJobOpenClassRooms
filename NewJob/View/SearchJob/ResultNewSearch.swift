//
//  ResultNewSearch.swift
//  NewJob
//
//  Created by Pierre on 11/03/2022.
//

import SwiftUI

struct ResultNewSearch: View {
    let pm: PersistenceManager
    @ObservedObject var vm: NewSearchJobViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea()
            if vm.jobs.count > 0 {
                CustomCardListJob(pm: pm, jobs: vm.jobs, width: UIScreen.main.bounds.width)
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)
            }
        }
        .navigationBarTitle(Text("Résulat"), displayMode:.inline)
        .toolbarBackground(
            Color.white,
            for: .navigationBar
        )
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear(){
            vm.jobs = []
            vm.getOffersOnPoleEmploi()
        }
    }
}

struct ResultNewSearch_Previews: PreviewProvider {
    static var previews: some View {
        ResultNewSearch(pm: PersistenceManager(), vm: NewSearchJobViewModel())
    }
}
