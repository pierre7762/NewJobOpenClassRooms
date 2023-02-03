//
//  ManualJobAddView.swift
//  NewJob
//
//  Created by Pierre on 23/01/2023.
//

import SwiftUI

struct AddWorkManualView: View {
    var pm: PersistenceManager
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: AddWorkManualViewModel = AddWorkManualViewModel()
    
    //    @FocusState private var nameIsFocused: Bool = false
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea()
            
            VStack {
                Text("Ajouter manuellement une candidature")
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.white)
                    .background(Color( white: 1.0, opacity: 0))
                    .padding()
                Form {
                    Section("Poste", content: {
                        TextField("Intitulé du poste", text: $vm.title)
                        TextField("Nom de l'entreprise", text: $vm.socityName)
                        TextField("Salaire", text: $vm.salary)
                    })
                    Section("Infos générales", content: {
                        TextField("Ville", text: $vm.cityName)
                        TextField("Lien vers l'annonce", text: $vm.jobLink)
                        TextField("Description", text: $vm.description, axis: .vertical)
                    })
                }
                HStack {
                    Spacer()
                    Button {
                        vm.createFavoriteJob()
                        dismiss()
                    } label: {
                        Text("Enregistrer")
                            .padding()
                            .foregroundColor(.white)
                            .background(.green)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.white, lineWidth: 2)
                            )
                    }
                    Spacer()
                }
                .padding()
            }
        }
        .onAppear(){
            vm.pm = pm
        }
    }
}

struct ManualJobAddView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkManualView(pm: PersistenceManager())
    }
}
