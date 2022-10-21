//
//  DestinataireView.swift
//  NewJob
//
//  Created by Pierre on 10/06/2022.
//

import SwiftUI

struct AddContactView: View {
    var jobId: String?
    var isModification: Bool?
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: AddContactViewModel = AddContactViewModel()
    

       var body: some View {
           GeometryReader { geometry in
               ZStack {

                   LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)

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
//                               if viewModel.searchContactPredicat.count > 0 {
//                                   List {
//                                       ForEach(viewModel.searchContactPredicat) { contact in
//                                           Button(contact.name ?? ""){
//                                               viewModel.affectResultSearchContactInForm(contact: contact)
//                                           }
//
//
//                                       }
//                                   }
//                               }
                               TextField("Entreprise" , text: $viewModel.contactCompagny)
                               TextField("Fonction" , text: $viewModel.contactFunctionInCompany)
                               TextField("Téléphone" , text: $viewModel.contactPhoneNumber)
                                   .keyboardType(.phonePad)
                               TextField("Mail" , text: $viewModel.contactMail)
                                   .keyboardType(.emailAddress)
                           }
                           
                           
                           
                       }
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
                           }
                           .cornerRadius(12)
                           .border(.white, width: 3)
                           .cornerRadius(12)
                           
                           Spacer()
                       }
                       .padding()
                       
                           
                 
                   }
                   .frame(minWidth: 0, maxWidth: 350, minHeight: 0, maxHeight: 800)
                   .padding()
                   Spacer()


           
               }
//               .onChange(of: viewModel.contactName) { newValue in
//                   viewModel.searchCompatibleContactName(name: newValue)
//               }
           
           }
           .onAppear() {
               viewModel.jobId = jobId ?? ""
           }
       }
        
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView(jobId: "", isModification: false)
    }
}
