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
                CustomCardListJob(jobs: newSearch.jobs, width: geometry.size.width)
            }
            .navigationBarTitle(Text("Dernière recherche"), displayMode:.inline)
            .onDisappear{
                newSearch.jobs = []
                newSearch.showResult = false
            }
        }
    }
}

struct ResultNewSearch_Previews: PreviewProvider {
    static var previews: some View {
        ResultNewSearch(newSearch: NewSearchJobViewModel())
    }
}
