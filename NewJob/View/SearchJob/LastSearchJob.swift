//
//  SearchJobParameter.swift
//  NewJob
//
//  Created by Pierre on 07/01/2022.
//

import SwiftUI

struct LastSearchJob: View {
    @ObservedObject private var searchViewModel = LastSearchJobViewModel()

    @State var text: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                if searchViewModel.jobs.count == 0 {
                    ProgressView("Chargement des offres ...")
                } else {
                    CustomCardListJob(jobs: searchViewModel.jobs, width: geometry.size.width)
                }
            }
            .navigationBarTitle(Text("Dernière recherche"), displayMode:.inline)
            .onAppear {
                searchViewModel.getOffersOnPoleEmploi()
            }
        }
    }
        
}



struct LastSearchJob_Previews: PreviewProvider {
    static var previews: some View {
        LastSearchJob()
    }
}

