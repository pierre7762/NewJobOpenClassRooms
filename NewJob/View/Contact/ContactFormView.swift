//
//  DestinataireView.swift
//  NewJob
//
//  Created by Pierre on 10/06/2022.
//

import SwiftUI

struct ContactFormView: View {
    let pm: PersistenceManager
    let actualContact: ContactDisplayable?
    var jobId: String?
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ContactFormViewModel = ContactFormViewModel()

       var body: some View {
           VStack {
               ZStack {

                   LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                       .ignoresSafeArea()
                   VStack {
                       DismissButtonView()
                       Form {
                           Section(header: Text(viewModel.title))  {
                               TextField("Nom" , text: $viewModel.contactName)
                                   .disableAutocorrection(true)
                               TextField("Entreprise" , text: $viewModel.contactCompagny)
                                   .disableAutocorrection(true)
                               TextField("Fonction" , text: $viewModel.contactFunctionInCompany)
                               TextField("Téléphone" , text: $viewModel.contactPhoneNumber)
                                   .keyboardType(.phonePad)
                               TextField("Mail" , text: $viewModel.contactMail)
                                   .keyboardType(.emailAddress)
                                   .textInputAutocapitalization(.never)
                                   .disableAutocorrection(true)
                           }
                       }
                       .cornerRadius(12)

                       HStack {
                           Spacer()
                           Button {
                               viewModel.actionToDo(actualContact: actualContact)
                               dismiss()
                           } label: {
                               Text("Enregistrer")
                                   .padding()
                                   .foregroundColor(.white)
                                   .background(.green)
                                   .overlay(
                                           RoundedRectangle(cornerRadius: 16)
                                               .stroke(.white, lineWidth: 2)
                                       )
                           }
                           Spacer()
                       }
                       .padding()
                   }
                   .frame(minWidth: 0, maxWidth: 350, minHeight: 0, maxHeight: 600)
                   .padding()
                   Spacer()
               }
           }
           .onAppear() {
               viewModel.pm = pm
               viewModel.jobId = jobId ?? ""
               viewModel.initContact(actualContact: actualContact)
           }
       }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactFormView(pm: PersistenceManager(), actualContact: nil, jobId: "")
    }
}
