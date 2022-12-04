//
//  DestinataireView.swift
//  NewJob
//
//  Created by Pierre on 10/06/2022.
//

import SwiftUI

struct AddContactView: View {
    let pm: PersistenceManager
    var jobId: String?
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: AddContactViewModel = AddContactViewModel()

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
                           .cornerRadius(12)
                       }
                 
                       Form {

                           Section(header: Text(viewModel.title))  {
                               TextField("Nom" , text: $viewModel.contactName)
                               TextField("Entreprise" , text: $viewModel.contactCompagny)
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
                               viewModel.createContact()
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
//                   .background(.red )
                   Spacer()

               }
//               .onChange(of: viewModel.contactName) { newValue in
//                   viewModel.searchCompatibleContactName(name: newValue)
//               }
           }
           .onAppear() {
               viewModel.pm = pm
               viewModel.jobId = jobId ?? ""
           }
       }
        
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView(pm: PersistenceManager(), jobId: "")
    }
}
