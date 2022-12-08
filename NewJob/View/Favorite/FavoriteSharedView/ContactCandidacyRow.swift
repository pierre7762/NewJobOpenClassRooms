//
//  ContactCandidacyRow.swift
//  NewJob
//
//  Created by Pierre on 14/10/2022.
//

import SwiftUI

struct ContactCandidacyRow: View {
    let pm: PersistenceManager
    var jobId: String
    @ObservedObject var job: SelectedJob
    @ObservedObject var vm: ActionsToBeTakenOnFavoriteJobViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            if job.candidacy?.contact?.count != nil {
                List {
                    ForEach(job.candidacy?.contact?.allObjects as! [Contact]) { contact in
                        NavigationLink(destination: ContactDetailsView(pm: pm, contact: ContactDisplayable(contact: contact, contactId: contact.id!), favoriteJobId: jobId)) {
                            Text(contact.name ?? "Inconnu")
                            if (contact.functionInCompany != nil) && contact.functionInCompany != "" {
                                Text(" (\(contact.functionInCompany!))")
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ContactCandidacyRow_Previews: PreviewProvider {
    static var previews: some View {
        ContactCandidacyRow(pm: PersistenceManager(), jobId: "", job: SelectedJob(), vm: ActionsToBeTakenOnFavoriteJobViewModel())
    }
}
