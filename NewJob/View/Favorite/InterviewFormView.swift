//
//  AddInterviewView.swift
//  NewJob
//
//  Created by Pierre on 11/11/2022.
//

import SwiftUI

struct InterviewFormView: View {
    let pm: PersistenceManager
    @State var candidacy: Candidacy?
    @State var interview: Interview?
    @State var showingDestinataireSheet: Bool = false
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: InterviewFormViewModel = InterviewFormViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                    .ignoresSafeArea()
                
                VStack {
                    DismissButtonView()
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
                            vm.actionToDo(candidacyID: (candidacy?.id)!, interviewId: interview?.id)
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
            vm.initInterviewForm(candidacyId: (candidacy?.id)!, interview: interview)
        }
    }
}

