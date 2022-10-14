//
//  ContactView.swift
//  NewJob
//
//  Created by Pierre on 07/01/2022.
//

import SwiftUI

struct ContactView: View {
    @ObservedObject var vm = ContactViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint,.green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                    .ignoresSafeArea()
                List {
                    ForEach(vm.contacts) { contact in
                        NavigationLink(destination: ContactDetailsView(contact: ContactDisplayable(contact: contact))) {
                            ContactRowView(contact: contact)
                        }
                    }
                }
 
            }
        }
        .onAppear() {
            vm.getContactsList()
        }
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}
