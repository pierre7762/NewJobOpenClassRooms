//
//  ResultNewSearch.swift
//  NewJob
//
//  Created by Pierre on 11/03/2022.
//

import SwiftUI

struct ResultNewSearch: View {
    @ObservedObject var newSearch: NewSearchJobViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                if newSearch.showResult {
                    CustomCardListJob(jobs: newSearch.jobs, width: geometry.size.width)
                } else {
                    VStack {
                        ProgressView()
                    }
                }
            }
            .navigationBarTitle(Text("Dernière recherche"), displayMode:.inline)
            .onAppear {
                newSearch.getOffersOnPoleEmploi()
            }
        }
    }
}

struct ResultNewSearch_Previews: PreviewProvider {
    static var previews: some View {
        ResultNewSearch(newSearch: NewSearchJobViewModel())
    }
}
