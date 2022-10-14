//
//  ContactCandidacyRow.swift
//  NewJob
//
//  Created by Pierre on 14/10/2022.
//

import SwiftUI

struct ContactCandidacyRow: View {
    var jobId: String
    @ObservedObject var job: SelectedJob
    @ObservedObject var vm: ActionsToBeTakenOnFavoriteJobViewModel
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Destinataire :")
                Spacer()

                Button {
                    vm.showingDestinataireSheet.toggle()
                } label: {
                    Image(systemName: "person.crop.circle.fill.badge.plus")
                        .font(.system(size: 30))
                        .foregroundColor(.blue)
                        .sheet(isPresented: $vm.showingDestinataireSheet) {
                            AddContactView(jobId: jobId)
//                                                    .environmentObject(viewModel)
                        }
                }
                .cornerRadius(12)

            }
            .buttonStyle(PlainButtonStyle())


            if job.candidacy?.contact?.count != nil {
                List {
                    ForEach(job.candidacy?.contact?.allObjects as! [Contact]) { item in
                        ContactThumbnail(contact: item)
                    }
                }
            }
        }
    }
}

struct ContactCandidacyRow_Previews: PreviewProvider {
    static var previews: some View {
        ContactCandidacyRow(jobId: "", job: SelectedJob(), vm: ActionsToBeTakenOnFavoriteJobViewModel())
    }
}
