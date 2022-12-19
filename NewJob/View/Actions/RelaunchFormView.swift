//
//  AddRelaunchView.swift
//  NewJob
//
//  Created by Pierre on 28/10/2022.
//

import SwiftUI

struct RelaunchFormView: View {
    let pm: PersistenceManager
    @State var currentRelaunch: Relaunch?
    @State var candidacy: Candidacy?
    @State var showingDestinataireSheet: Bool = false
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: RelaunchFormViewModel = RelaunchFormViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                    .ignoresSafeArea()
                VStack {
                    DismissButtonView()
                    Form {
                        Section(header: Text("Relance")) {
                            RelaunchPickerDateView(vm: vm)
                            RelaunchPickerMeansView(vm: vm)
                        }
                        
                        Section(header: Text("Contact")) {
                            Picker("Non précisé", selection: $vm.contactSelected) {
                                Text("Non précisé").tag("Non précisé")
                                ForEach(vm.contactList, content: { contact in
                                    if contact.compagny != "" {
                                        Text("\(contact.name!) (\(contact.compagny!))").tag(contact.name!)
                                    } else {
                                        Text("\(contact.name!)").tag(contact.name!)
                                    }
                                })
                            }
                            .pickerStyle(.menu)
                        }
                        
                        Section(header: Text("Informations")){
                            TextEditor(text: $vm.comment)

                        }
                    }
                    .frame(minWidth: 0, maxWidth: 350, minHeight: 0, maxHeight: 600)
                    .cornerRadius(12)
                    .padding()
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button {
                            vm.actionToDo(candidacyID: (candidacy?.id)!, relaunchId: currentRelaunch?.id)
                            dismiss()
                        } label: {
                            Text("Enregistrer")
                                .padding()
                                .foregroundColor(.white)
                                
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(.white, lineWidth: 2)
                                )
                                .background(.green)
                                .cornerRadius(16)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    Spacer()
                }
            }
        }
        .onAppear() {
            vm.pm = pm
            vm.fetchCandidacyContactList(candidacyId: candidacy!.id!)
            vm.initRelaunch(currentRelaunch: currentRelaunch)
        }
    }
}

struct AddRelaunchView_Previews: PreviewProvider {
    static var previews: some View {
        RelaunchFormView(pm: PersistenceManager())
    }
}
