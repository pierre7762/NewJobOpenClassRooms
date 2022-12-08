//
//  InterviewDetailsView.swift
//  NewJob
//
//  Created by Pierre on 11/11/2022.
//

import SwiftUI

struct InterviewDetailsView: View {
    let pm: PersistenceManager
    @State var interview: Interview
    @State var vm: ActionsToBeTakenOnFavoriteJobViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showingAlert = false
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint,.green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea()
            if interview.date != nil {
                VStack {
                    List {
                        Section(header: Text("Date")) {
                            Text("\(vm.converteDateToString(date: interview.date!))")
                        }
                        if interview.contact != nil {
                            Section(header: Text("Contact")) {
                                NavigationLink(destination: ContactDetailsView(pm: pm, contact: ContactDisplayable(contact: interview.contact!, contactId: interview.contact!.id!), favoriteJobId: (vm.favoriteJob?.id)!)) {
                                    Text(interview.contact!.name ?? "Inconnu")
                                    if (interview.contact!.functionInCompany != nil) && interview.contact!.functionInCompany != "" {
                                        Text(" (\(interview.contact!.functionInCompany!))")
                                    }
                                }
                            }
                        }
                        
                        Section(header: Text("Informations")){
                            Text("\((interview.comment == "" ? "Pas d'informations renseignées" : interview.comment!))")
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
                        .alert("Supprimer l'entretien ?", isPresented: $showingAlert) {
                            Button("Supprimer", role: .destructive) {
                                presentationMode.wrappedValue.dismiss()
                                vm.removeInterview(interviewId: interview.id!)
                            }
                            Button("Annuler", role: .cancel) {}
                        }
                }
                .padding()
            }
        }
        .navigationBarTitle(Text("Entretien"), displayMode:.inline)
        .toolbarBackground(
            Color.white,
            for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct InterviewDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        InterviewDetailsView(pm: PersistenceManager(), interview: Interview(), vm: ActionsToBeTakenOnFavoriteJobViewModel())
    }
}
