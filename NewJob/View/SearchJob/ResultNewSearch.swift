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
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea()
            CustomCardListJob(jobs: newSearch.jobs, width: UIScreen.main.bounds.width)
        }
        .navigationBarTitle(Text("Dernière recherche"), displayMode:.inline)
        .toolbarBackground(
            Color.white,
            for: .navigationBar
        )
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct ResultNewSearch_Previews: PreviewProvider {
    static var previews: some View {
        ResultNewSearch(newSearch: NewSearchJobViewModel())
    }
}
