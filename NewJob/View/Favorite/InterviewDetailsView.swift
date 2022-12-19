//
//  InterviewDetailsView.swift
//  NewJob
//
//  Created by Pierre on 11/11/2022.
//

import SwiftUI

struct InterviewDetailsView: View {
    let pm: PersistenceManager
    let jobId: String?
    @State var interview: Interview
    @State var candidacy: Candidacy
    @State var showingUpdateInterviewSheet: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var vm: InterviewDetailsViewModel = InterviewDetailsViewModel()
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
                                NavigationLink(destination: ContactDetailsView(pm: pm, contact: ContactDisplayable(contact: interview.contact!, contactId: interview.contact!.id!), favoriteJobId: jobId!)) {
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
                                vm.pm.removeInterview(interviewId: interview.id!)
                            }
                            Button("Annuler", role: .cancel) {}
                        }
                }
                .padding()
            }
        }
        .onAppear(){
            vm.pm = pm
        }
        .onChange(of: showingUpdateInterviewSheet, perform: { newValue in
            vm.loadInterviewDetails(interviewId: interview.id!)
        })
        .navigationBarTitle(Text("Entretien"), displayMode:.inline)
        .toolbarBackground(
            Color.white,
            for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            Button {
                showingUpdateInterviewSheet.toggle()
            } label: {
                Text("Modifier")
            }
            .sheet(isPresented: $showingUpdateInterviewSheet) {
                InterviewFormView(pm: pm, candidacy: candidacy, interview: interview)
            }
        }
    }
}

struct InterviewDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        InterviewDetailsView(pm: PersistenceManager(), jobId: "", interview: Interview(), candidacy: Candidacy(), vm: InterviewDetailsViewModel())
    }
}
