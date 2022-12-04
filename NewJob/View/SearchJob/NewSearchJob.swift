//
//  SearchJobTextFieldView.swift
//  NewJob
//
//  Created by Pierre on 07/01/2022.
//

import WrappingStack
import SwiftUI

struct NewSearchJob: View {
    let pm: PersistenceManager
    @ObservedObject private var vm = NewSearchJobViewModel()
    @State private var qualificationState = 0
    
    private let poleEmploiService = PoleEmploiService()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea()
            
            VStack {
                VStack (alignment: .leading) {
                    FormNewSearchJob(vm: vm)
                    Spacer()
                    HStack {
                        Spacer()
                        if vm.requestInProgress {
                            ProgressView()
                        } else {
                            NavigationLink(
                                destination: ResultNewSearch(pm: pm, vm: vm),
                                label: {
                                    Text("Rechercher")
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(.green)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(.white, lineWidth: 2)
                                        )
                                }
                            )
                        }
                        
                        Spacer()
                    }
                    Spacer()
                }
                .padding()
            }
            .onAppear() {
                vm.showResult = false
            }
            .navigationBarTitle(Text("Nouvelle recherche"), displayMode:.inline)
            .toolbarBackground(
                Color.white,
                for: .navigationBar
            )
            .toolbarBackground(.visible, for: .navigationBar)
            .alert("Une erreur est survenue. \n Veuillez vérifier les informations saisies.", isPresented: $vm.showAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }
}

struct NewSearchJob_Previews: PreviewProvider {
    static var previews: some View {
        NewSearchJob(pm: PersistenceManager())
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

