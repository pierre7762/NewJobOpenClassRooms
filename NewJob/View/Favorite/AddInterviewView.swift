//
//  AddInterviewView.swift
//  NewJob
//
//  Created by Pierre on 11/11/2022.
//

import SwiftUI

struct AddInterviewView: View {
//    @State var isCreateOrModify: CreateOrModify
//    @State var actualRelaunch: Relaunch?
//    @State var candidacy: Candidacy?
    let pm: PersistenceManager
    @State var candidacy: Candidacy?
    @State var showingDestinataireSheet: Bool = false
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: AddInterviewViewModel = AddInterviewViewModel()
    
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
                        Section(header: Text("Entretien")) {
                            DatePicker(
                                    "Du :",
                                    selection: $vm.createDateInterview,
                                    displayedComponents: [.date]
                                )
                            .datePickerStyle(.compact)
                            Picker("Contact", selection: $vm.contactSelected) {
                                Text("Non précisé").tag("Non précisé")
                                ForEach(vm.contactList, content: { contact in
                                    Text("\(contact.name!) (\(contact.compagny!))").tag(contact.name!)
                                })
                            }
                            .pickerStyle(.menu)
                        }
                        Section(header: Text("Informations")){
                            TextEditor(text: $vm.interviewComment)
                        
                        }
                    }
                    .frame(minWidth: 0, maxWidth: 350, minHeight: 0, maxHeight: 600)
                    .cornerRadius(12)
                    .padding()
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button {
                            vm.createInterview(candidacyId: (candidacy?.id)!)
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
            vm.fetchCandidacyContactList(candidacyId: (candidacy?.id)!)
        }
    }
}

//struct AddInterviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddInterviewView()
//    }
//}
