//
//  DestinataireView.swift
//  NewJob
//
//  Created by Pierre on 10/06/2022.
//

import SwiftUI

struct AddContactView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel = ActionsToBeTakenOnFavoriteJobViewModel()
    

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

                           Section(header: Text("Ajouter votre contact"))  {
                               TextField("Nom" , text: $viewModel.contactName)
                               TextField("Entreprise" , text: $viewModel.contactCompagny)
                               TextField("Fonction" , text: $viewModel.contactFunctionInCompany)
                               TextField("Téléphone" , text: $viewModel.contactPhoneNumber)
                               TextField("Mail" , text: $viewModel.contactMail)
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
           
           }
       }
        
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView()
    }
}
