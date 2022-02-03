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
        GeometryReader { geometry in
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)
//                    .ignoresSafeArea()
                if searchViewModel.jobs.count == 0 {
                    ProgressView("Chargement des offres ...")
                        
                } else {
                    VStack {
                        ScrollView(.vertical, showsIndicators: true) {
                            VStack {
                                ForEach(searchViewModel.jobs) { job in
                                    NavigationLink(
                                        destination: JobDetails(job: job),
                                        label: {
                                            VStack(alignment: .leading) {
                                                HStack(alignment: .lastTextBaseline) {
                                                    Text(job.appellationlibelle)
                                                        .fontWeight(.bold)
                                                        .font(.footnote)
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
                                            .frame(width: geometry.size.width * 0.8, alignment: .leading)
                                            .padding()
                                            .background(Color(white: 1.0))
                                        }
                                    )
                                        .cornerRadius(12)
                                }
                            }
                        }
                    }
                    .padding(.init(top: 5, leading: 10, bottom: 5, trailing: 10))
                }
                
               
            }
            .navigationBarTitle(Text("Dernière recherche"), displayMode:.inline)
            .onAppear {
                searchViewModel.fetchPoleEmploiJobs()
            }
        }
        }
        
}



struct SearchJobParameter_Previews: PreviewProvider {
    static var previews: some View {
        SearchJobParameter()
    }
}

