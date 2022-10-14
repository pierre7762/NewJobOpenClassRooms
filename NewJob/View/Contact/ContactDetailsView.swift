//
//  ContactDetails.swift
//  NewJob
//
//  Created by Pierre on 26/08/2022.
//

import SwiftUI

struct ContactDetailsView: View {
    let contact: ContactDisplayable
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint,.green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                    .ignoresSafeArea()
                VStack() {
//                    Text(contact.name ?? "Pas de nom de contact")
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
                            ContactInfoLineView(text: contact.phoneNumber, iconName: "phone", clickableType: .phoneNumer)
                            ContactInfoLineView(text: contact.email, iconName: "mail", clickableType: .email)
                        }
                        Section {
                            HStack{
                                Image(systemName: "phone")
                                    .foregroundColor(.black)
                                Text("test@test.fr")
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    
                    
                    Spacer()
                    Spacer()
                }
                .padding()
//                .frame(width: geometry.size.width - 30, height: 300)
//                .background().foregroundColor(.white)
//                .cornerRadius(12)
                
                
                
 
            }
            .onAppear() {
                print(contact.candidacy)
            }
        }
    }
}

struct ContactDetailsView_Previews: PreviewProvider {
    static var people: ContactDisplayable = ContactDisplayable(contact: Contact())
    
    
    static var previews: some View {
        ContactDetailsView(contact: people)
    }
}
