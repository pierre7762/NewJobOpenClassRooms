//
//  ContactRowView.swift
//  NewJob
//
//  Created by Pierre on 26/08/2022.
//

import SwiftUI

struct ContactRowView: View {
    var contact : Contact
    var body: some View {
        VStack {
            Text(contact.name!)
                .font(.title2)
                .bold()
            Text(contact.compagny!)
                .font(.subheadline)

        }
    }
}

struct ContactRowView_Previews: PreviewProvider {
    static var previews: some View {
        ContactRowView(contact: Contact())
    }
}
