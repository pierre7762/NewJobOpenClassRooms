//
//  ContactThumbnail.swift
//  NewJob
//
//  Created by Pierre on 07/07/2022.
//

import SwiftUI

struct ContactThumbnail: View {
    var contact: Contact
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .font(.system(size: 30))
            VStack(alignment: .leading) {
                Text("\(contact.name ?? "") (\(contact.functionInCompany ?? ""))")
                    .font(.headline)
                Text(contact.compagny ?? "")
                    .font(.subheadline)
                if contact.phoneNumber != "" {
                    HStack {
                        Image(systemName: "phone.fill")
                            .font(.system(size: 20))
                        Text(contact.phoneNumber ?? "")
                            .padding()
                    }
                }
                if contact.email != "" {
                    HStack {
                        Image(systemName: "mail.fill")
                            .font(.system(size: 20))
                        Text(contact.email ?? "")
                            .padding()
                    }
                }
            }
            .padding()
        }
        
    }
}

struct ContactThumbnail_Previews: PreviewProvider {
    static var contact = Contact()
    static var previews: some View {
        ContactThumbnail(contact: Contact())
            .previewLayout(.sizeThatFits)
    }
}
