//
//  ContactDetails.swift
//  NewJob
//
//  Created by Pierre on 26/08/2022.
//

import SwiftUI

struct ContactDetailsView: View {
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
                            HStack{
                                Image(systemName: "phone.fill")
                                    .foregroundColor(.black)
                                    .font(.system(size: 30))
                                Link("\(contact.phoneNumber)", destination: URL(string: "tel:\(contact.phoneNumber)")!)
                            }
                            if contact.email != ""{
                                HStack{
                                    Image(systemName: "mail")
                                        .foregroundColor(.black)
                                        .font(.system(size: 30))
                                    Link("\(contact.email)", destination: URL(string: "mailto:\(contact.email)")!)
                                }
                            }
                        }
                        Section (header: Text("Informations")){
                            Text("Société : \(contact.compagny)")
                            Text("Poste : \(contact.functionInCompany)")
                        }
                        Section (header: Text("Candidatures liées")){
            
                        }
                    }
                    .cornerRadius(12)
                    
                    Spacer()
                    Spacer()
                    
                    Button {
                        showingAlert.toggle()
                    } label: {
                        Text("Supprimer")
                            .font(.body)
                            .foregroundColor(.red)
                    }
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
            .toolbar {
                Button(action: {print("TODO: make modification contact")}) {
                    Text("Modifier")
                }
                .sheet(isPresented: $vm.showingDestinataireSheet) {
//                    AddContactView(jobId:)
                }
            }
            .onAppear() {
                print("contact : ", contact.email)
            }
    }
}

struct ContactDetailsView_Previews: PreviewProvider {
    static var people: ContactDisplayable = ContactDisplayable(contact: Contact())
    
    
    static var previews: some View {
        ContactDetailsView(contact: people)
    }
}
