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
    let favoriteJobId: String
    var mail = ""
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showingAlert = false
    @StateObject var vm: ContactDetailsViewModel = ContactDetailsViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint,.green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea()
                VStack() {
                    Text(vm.contact?.name ?? "")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .font(.title)
                    Text(vm.contact?.compagny ?? "")
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                        .font(.subheadline)
                    List {
                        Section {
                            if vm.contact?.phoneNumber != "" {
                                HStack{
                                    Image(systemName: "phone.fill")
                                        .foregroundColor(.black)
                                        .font(.system(size: 30))
                                    Text(vm.contact?.phoneNumber ?? "")
                                        .textSelection(.enabled)
                                }
                            }
                            if vm.contact?.email != ""{
                                HStack{
                                    Image(systemName: "mail")
                                        .foregroundColor(.black)
                                        .font(.system(size: 30))
                                    Text(vm.contact?.email ?? "")
                                        .textSelection(.enabled)
                                }
                            }
                        }
                        if vm.contact?.functionInCompany != "" && vm.contact?.compagny != "" {
                            Section (header: Text("Informations")){
                                Text("Société : \(vm.contact?.compagny ?? "")")
                                Text("Poste : \(vm.contact?.functionInCompany ?? "")")
                            }
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
                                vm.deleteContact(id: vm.contact!.contactId)
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
            Button {
                vm.showingUpdateContactSheet.toggle()
            } label: {
                Text("Modifier")
            }
            .sheet(isPresented: $vm.showingUpdateContactSheet) {
                ContactFormView(pm: pm, actualContact: contact, jobId: favoriteJobId)
            }
        }
        .onAppear(){
            vm.pm = pm
            vm.updateContactData(contactId: contact.contactId)
        }
        .onChange(of: vm.showingUpdateContactSheet) { newValue in
            if newValue == false {
                vm.updateContactData(contactId: contact.contactId)
            }
        }
    }
}

struct ContactDetailsView_Previews: PreviewProvider {
    static var people: ContactDisplayable = ContactDisplayable(contact: Contact(), contactId: UUID())
    
    
    static var previews: some View {
        ContactDetailsView(pm: PersistenceManager(), contact: people, favoriteJobId: "")
    }
}
