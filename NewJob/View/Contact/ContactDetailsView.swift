//
//  ContactDetails.swift
//  NewJob
//
//  Created by Pierre on 26/08/2022.
//

import SwiftUI

struct ContactDetailsView: View {
    let pm: PersistenceManager
    let contact: ContactDisplayable
    var mail = ""
    @ObservedObject var vm: ContactDetailsViewModel = ContactDetailsViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showingAlert = false
    
    var body: some View {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint,.green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                    .ignoresSafeArea()
                VStack() {
                    Text(contact.name)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .font(.title)
                    Text(contact.compagny)
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                        .font(.subheadline)
                    List {
                        Section {
                            if contact.phoneNumber != "" {
                                HStack{
                                    Image(systemName: "phone.fill")
                                        .foregroundColor(.black)
                                        .font(.system(size: 30))
                                    Link("\(contact.phoneNumber)", destination: URL(string: "tel:\(contact.phoneNumber)")!)
                                }
                            }
                            if contact.mailUnwrapped != ""{
                                HStack{
                                    Image(systemName: "mail")
                                        .foregroundColor(.black)
                                        .font(.system(size: 30))
                                    Link("\(contact.mailUnwrapped)", destination: URL(string: "mailto:\(contact.mailUnwrapped)")!)
                                }
                            }
                        }
                        Section (header: Text("Informations")){
                            Text("Société : \(contact.compagny)")
                            Text("Poste : \(contact.functionInCompany)")
                        }
                        Section (header: Text("Candidatures liées")){
                            List {
                                ForEach(vm.candidacyArray) { candidacy in
                                    Text(candidacy.selectedJob?.entitled ?? "rien")
                                }
                            }
                            .scrollContentBackground(.hidden)
                            
//                            List {
//                                ForEach($vm.candidacy.allObjects as! [Candidacy]) { cand in
//                                    Text((cand.selectedJob?.entitled)!)
//                                }
//                            }
                        }
                    }
                    .cornerRadius(12)
                    
                    Spacer()
                    Spacer()
                    
                    Button("Supprimer", action: {showingAlert.toggle()})
                        .padding()
                        .foregroundColor(.white)
                        .background(.red)
                        .cornerRadius(12)
                        .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.white, lineWidth: 2)
                            )
                    .alert("Supprimer le contact ?", isPresented: $showingAlert) {
                        Button("Supprimer", role: .destructive) {
                            vm.deleteContact(id: contact.id)
                            presentationMode.wrappedValue.dismiss()
                        }
                        Button("Annuler", role: .cancel) {}
                    }
                }
                .padding()
            }
            .toolbarBackground(
                Color.white,
                for: .navigationBar
            )
            .toolbarBackground(.visible, for: .navigationBar)
            .onAppear(){
                vm.pm = pm
                vm.fetchCandidaciesWhoAreConnectedAtThisContact(contactID: contact.id)
            }
    }
}

struct ContactDetailsView_Previews: PreviewProvider {
    static var people: ContactDisplayable = ContactDisplayable(contact: Contact())
    
    
    static var previews: some View {
        ContactDetailsView(pm: PersistenceManager(), contact: people)
    }
}
