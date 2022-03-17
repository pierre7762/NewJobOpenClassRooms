//
//  SearchJobTextFieldView.swift
//  NewJob
//
//  Created by Pierre on 07/01/2022.
//

import WrappingStack
import SwiftUI

struct NewSearchJob: View {
    @ObservedObject private var newSearchJob = NewSearchJobViewModel()
    
    private let poleEmploiService = PoleEmploiService()
    

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                
                VStack {

                    VStack (alignment: .leading) {
                        HStack() {
                            Text("Poste recherché ")
                                .fontWeight(.bold)
                                .font(.title)
                            
                            Spacer()
                        }
                        
                        TextField("Entrez un poste", text: $newSearchJob.search.jobTitle, onCommit: {
                            //Action quand le clavier rentre (fin d'édition)
                            
                            print("Commit")
                        })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .submitLabel(.done)
                        
                        TextField("Ville ", text: $newSearchJob.search.city)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        HStack {
                            Text("Expérience : ")
                                .font(.body)
                            Picker("experience", selection: $newSearchJob.search.experience) {
                                Text("Non précisé").tag(0)
                                Text("Moins d'un an").tag(1)
                                Text(" De 1 à 3 ans").tag(2)
                                Text("Plus de 3 ans").tag(3)
                            }
                            .pickerStyle(.menu)
                        }
                        HStack {
                            Text("Qualifications : ")
                                .font(.body)
                            Picker("qualification", selection: $newSearchJob.search.qualification) {
                                Text("Non précisé").tag(0)
                                Text("Non cadre").tag(1)
                                Text("Cadre").tag(2)
                            }
                            .pickerStyle(.menu)
                        }
                        HStack {
                            Text("Type de contrat : ")
                                .font(.body)
                            Picker("contrat", selection: $newSearchJob.search.contract) {
                                Text("Non précisé").tag(0)
                                Text("CDI").tag(1)
                                Text("CDD").tag(2)
                            }
                            .pickerStyle(.menu)
                        }
                        Spacer()
                        
                        HStack {
                            Spacer()
                            NavigationLink(
                                destination: ResultNewSearch(newSearch: newSearchJob),
                                label: {
                                    Text("Rechercher")
                                }
                                
                            )
//                            Button("Rechercher", action: newSearchJob.getOffersOnPoleEmploi )
//                                .frame(width: 100, height: 50, alignment: .center)
//                                .background()
//                                .cornerRadius(12)
                            
                            Spacer()
                        }
                    }
                    .padding()
                    .frame(width: geometry.size.width * 0.9 , height: geometry.size.height * 0.85 , alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(20)
                    
                }
                .padding()
                
            }
        }
        .navigationBarTitle(Text("Nouvelle recherche"), displayMode:.inline)
    }
}

struct NewSearchJob_Previews: PreviewProvider {
    static var previews: some View {
        NewSearchJob()
    }
}


struct SheetParametersView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button("Press to dismiss") {
            dismiss()
        }
        .font(.title)
        .padding()
        .background(Color.black)
    }
}
