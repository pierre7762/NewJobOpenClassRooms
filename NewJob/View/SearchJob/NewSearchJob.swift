//
//  SearchJobTextFieldView.swift
//  NewJob
//
//  Created by Pierre on 07/01/2022.
//

import WrappingStack
import SwiftUI

struct NewSearchJob: View {
    @ObservedObject private var viewModel = NewSearchJobViewModel()
    @State private var qualificationState = 0
    
    private let poleEmploiService = PoleEmploiService()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                
                VStack {

                    VStack (alignment: .leading) {
                        FormNewSearchJob(viewModel: viewModel)
                        
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            NavigationLink(destination: ResultNewSearch(newSearch: viewModel), isActive: $viewModel.showResult) { EmptyView() }
                            if viewModel.requestInProgress {
                                ProgressView()
                            } else {
                                Button("Rechercher", action: viewModel.getOffersOnPoleEmploi)
                            }
                            
                            Spacer()
                        }
                    }
//                    .padding()
//                    .frame(width: geometry.size.width * 0.9 , height: geometry.size.height * 0.85 , alignment: .leading)
//                    .background(Color.white)
//                    .cornerRadius(20)
                    
                }
                .padding()
                
            }
        }
        .onChange(of:viewModel.search.city , perform: { _ in
            viewModel.fetchCityCodeFromCityName()
        })
        .navigationBarTitle(Text("Nouvelle recherche"), displayMode:.inline)
        .alert("Une erreur est survenue. \n Veuillez vérifier les informations saisies.", isPresented: $viewModel.showAlert) {
                    Button("OK", role: .cancel) { }
                }
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

