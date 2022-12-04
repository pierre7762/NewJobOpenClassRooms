//
//  ContactView.swift
//  NewJob
//
//  Created by Pierre on 07/01/2022.
//

import SwiftUI

struct ContactListView: View {
    let pm: PersistenceManager
    @ObservedObject var vm = ContactListViewModel()
    
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
                    NavigationLink(destination: ContactDetailsView(pm: pm, contact: ContactDisplayable(contact: contact))) {
                        ContactRowView(contact: contact)
                    }
                    .isDetailLink(false)
                }
                .onDelete(perform: delete)
            }
            .scrollContentBackground(.hidden)
        }
        .navigationBarTitle(Text("Contacts"), displayMode:.inline)
        .toolbarBackground(
            Color.white,
            for: .navigationBar
        )
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear() {
            vm.pm = pm
            vm.getContactsList()
        }
        .onChange(of: vm.showingDestinataireSheet) { newValue in
            vm.getContactsList()
        }
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactListView(pm: PersistenceManager())
    }
}
