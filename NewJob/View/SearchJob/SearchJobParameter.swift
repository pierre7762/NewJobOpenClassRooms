//
//  SearchJobParameter.swift
//  NewJob
//
//  Created by Pierre on 07/01/2022.
//

import SwiftUI

struct SearchJobParameter: View {
    @ObservedObject private var searchViewModel = SearchJobParameterViewModel()

    @State var text: String = ""
    
    var body: some View {

        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea()
            if searchViewModel.jobs.count == 0 {
                ProgressView("Chargement des offres ...")
                    
            } else {
                VStack {

                    List(searchViewModel.jobs) { job in
                        NavigationLink(
                            destination: JobDetails(),
                            label: {
                                VStack(alignment: .leading) {
                                   
                                    HStack() {
                                        Text(job.appellationlibelle)
                                            .fontWeight(.bold)
                                            .font(.footnote)
        //                                Text(job.)
                                    }
                                    Text(job.entreprise.nom ?? "")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                    Text(job.lieuTravail.libelle )
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Text(job.salaire.commentaire ?? "")
                                        .font(.footnote)
                                }
                            }
                        )

                        
                    }
                }.padding()
            }
            
           
        }
        .onAppear {
            searchViewModel.fetchPoleEmploiJobs()
        }
    }
}



struct SearchJobParameter_Previews: PreviewProvider {
    static var previews: some View {
        SearchJobParameter()
    }
}

