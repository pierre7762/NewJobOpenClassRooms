//
//  RelaunchDetailsView.swift
//  NewJob
//
//  Created by Pierre on 04/11/2022.
//

import SwiftUI

struct RelaunchDetailsView: View {
    @State var relaunch: Relaunch
    @ObservedObject var vm: RelaunchDetailsViewModel = RelaunchDetailsViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showingAlert = false
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint,.green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea()
            VStack {
                if relaunch.date != nil {
                    List {
                        Section(header: Text("Date")) {
                            Text("\(vm.converteDateToString(date: relaunch.date!))")
                        }
                        Section(header: Text("Effectuée par ")) {
                            Text(relaunch.means!)
                        }
                        if relaunch.contact != nil {
                            Section(header: Text("Contact")) {
                                NavigationLink(destination: ContactDetailsView(contact: ContactDisplayable(contact: relaunch.contact!))) {
                                    Text(relaunch.contact!.name ?? "Inconnu")
                                    if (relaunch.contact!.functionInCompany != nil) && relaunch.contact!.functionInCompany != "" {
                                        Text(" (\(relaunch.contact!.functionInCompany!))")
                                    }
                                }
                            }
                        }
                        Section(header: Text("Informations")){
                            Text("\((relaunch.comment == "" ? "Pas d'informations renseignées" : relaunch.comment!))")
                        }
                        
                    }
                    .cornerRadius(12)
                }
                
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
                    .alert("Supprimer la relance ?", isPresented: $showingAlert) {
                        Button("Supprimer", role: .destructive) {
                            presentationMode.wrappedValue.dismiss()
                            vm.removeRelaunch(relaunchID: relaunch.id!)
                            
                        }
                        Button("Annuler", role: .cancel) {}
                    }
            }
            .padding()
        }
        .navigationBarTitle(Text("Relance"), displayMode:.inline)
        .toolbarBackground(
            Color.white,
            for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct RelaunchDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RelaunchDetailsView(relaunch: Relaunch())
    }
}
