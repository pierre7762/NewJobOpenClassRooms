//
//  ContactDetailUpdateView.swift
//  NewJob
//
//  Created by Pierre on 28/10/2022.
//

import SwiftUI

struct ContactDetailUpdateView: View {
    let contact: ContactDisplayable
    @Environment(\.dismiss) var dismiss
//    @ObservedObject var vm: AddContactViewModel = AddContactViewModel()
    @ObservedObject var vm: ContactDetailUpdateViewModel = ContactDetailUpdateViewModel()
    

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

                           Section()  {
//                               TextField("Nom", text: $vm.name)
                               Text("test")
                                   .onLongPressGesture(minimumDuration: 1.0) {
                                       print("press")
                                   }

                               
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
//                               TextField("Entreprise" , text: $vm.contactCompagny)
//                               TextField("Fonction" , text: $vm.contactFunctionInCompany)
//                               TextField("Téléphone" , text: $vm.contactPhoneNumber)
//                                   .keyboardType(.phonePad)
//                               TextField("Mail" , text: $vm.contactMail)
//                                   .keyboardType(.emailAddress)
//                                   .textInputAutocapitalization(.never)
//                                   .disableAutocorrection(true)
                           }
                           
                           
                           
                       }
                       HStack {
                           Spacer()
                           Button {
                               print("todo")
//                               vm.createContact()
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
               .onAppear(){
                   vm.initParams(contactDisplay: contact)
               }
               .onChange(of: vm.name) { newValue in
                   print("name : ", vm.name)
               }
           
           }
       }
}

struct ContactDetailUpdateView_Previews: PreviewProvider {
    static var people: ContactDisplayable = ContactDisplayable(contact: Contact())
    
    
    static var previews: some View {
        ContactDetailUpdateView(contact: ContactDisplayable(contact: Contact()))
    }
    
}
