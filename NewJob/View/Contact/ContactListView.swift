//
//  ContactView.swift
//  NewJob
//
//  Created by Pierre on 07/01/2022.
//

import SwiftUI

struct ContactListView: View {
    @ObservedObject var vm = ContactViewModel()
    
    func delete(offsets: IndexSet) {
        for off in offsets {
            vm.deleteContact(id: vm.contacts[off].id!)
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint,.green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea()
            if vm.contacts.count == 0 {
                Text("Ajoutez votre premier contact")
            }
            List {
                ForEach(vm.contacts) { contact in
                    NavigationLink(destination: ContactDetailsView(contact: ContactDisplayable(contact: contact))) {
                        ContactRowView(contact: contact)
                    }
                    .isDetailLink(false)
                }
                .onDelete(perform: delete)
            }
            .scrollContentBackground(.hidden)
        }
        .toolbarBackground(
            Color.white,
            for: .navigationBar
        )
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            Button(action: {vm.showingDestinataireSheet.toggle()}) {
                Image(systemName: "person.crop.circle.badge.plus")
            }
        }
        .sheet(isPresented: $vm.showingDestinataireSheet) {
            AddContactView()
        }
        .onAppear() {
            vm.getContactsList()
        }
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactListView()
    }
}
