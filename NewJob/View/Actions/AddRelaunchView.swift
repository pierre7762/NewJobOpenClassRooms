//
//  AddRelaunchView.swift
//  NewJob
//
//  Created by Pierre on 28/10/2022.
//

import SwiftUI

struct AddRelaunchView: View {
    @State var isCreateOrModify: CreateOrModify
    @State var actualRelaunch: Relaunch?
    @State var candidacy: Candidacy?
    @State var showingDestinataireSheet: Bool = false
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: AddRelaunchViewModel = AddRelaunchViewModel(isCreateOrModify: .create, relaunch: nil)
    
    var body: some View {
        VStack {
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                    .ignoresSafeArea()
                VStack {
                    HStack() {
                        Spacer()
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                        }
                        .padding()
                        .cornerRadius(12)
                    }
                    
                    Form {
                        Section(header: Text("Relance")) {
                            RelaunchPickerDateView(vm: vm, isCreateOrModify: .create)
                            RelaunchPickerMeansView(vm: vm, isCreateOrModify: .create)
                        }
                        
                        Section(header: Text("Contact")) {
                            Picker("Non précisé", selection: $vm.contactSelected) {
                                Text("Non précisé").tag("Non précisé")
                                ForEach(vm.contactList, content: { contact in
                                    Text("\(contact.name!) (\(contact.compagny!))").tag(contact.name!)
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
                            vm.createRelaunch(candidacyID: (candidacy?.id)!)
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
            vm.fetchCandidacyContactList(candidacyId: candidacy!.id!)
        }
    }
}

struct AddRelaunchView_Previews: PreviewProvider {
    static var previews: some View {
        AddRelaunchView(isCreateOrModify: .create)
    }
}
