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
    @Environment(\.dismiss) var dismiss
    @State var vm: ActionsToBeTakenOnFavoriteJobViewModel
    
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
                            PickerDateView(typeOfView: .interview, vm: vm)
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
                            vm.createInterview()
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
//            vm.fetchCandidacyContactList(candidacyId: candidacy!.id!)
        }
    }
}

//struct AddInterviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddInterviewView()
//    }
//}
