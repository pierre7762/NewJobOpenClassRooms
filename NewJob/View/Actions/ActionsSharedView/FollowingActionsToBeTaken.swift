//
//  FollowingActionsToBeTaken.swift
//  NewJob
//
//  Created by Pierre on 18/11/2022.
//

import SwiftUI

struct FollowingActionsToBeTaken: View {
    var headerTitle: String
    var object: [SelectedJobWithnumberOfDaysFromCandidacy]
    var emptyText: String
    
    var body: some View {
        Section(header:
                    Text(headerTitle)
            .foregroundColor(.white)
            .font(Font.headline.weight(.bold))
        )  {
            if object.count > 0 {
                ForEach(object) { job in
                    NavigationLink(
                        destination:  SelectedJobMenuView(job: job.selectedJob, jobId: job.selectedJob.id!),
                        label: {
                            VStack(alignment: .leading) {
                                HStack(alignment: .lastTextBaseline) {
                                    Text("")
                                    Text(job.selectedJob.entitled ?? "")
                                        .fontWeight(.bold)
                                        .font(.footnote)
                                }
                                Text(job.selectedJob.company?.name ?? "")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                Text(job.selectedJob.workplace?.libelle ?? "")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text(" Il y à \(job.numberOfDaysFromCandidacy) jours")
                                    .font(.footnote)
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.8, alignment: .leading)
                            .background(Color(white: 1.0))
                        }
                    )
                }

            } else {
                Text(emptyText)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct FollowingActionsToBeTaken_Previews: PreviewProvider {
    static var previews: some View {
        FollowingActionsToBeTaken(headerTitle: "", object: [], emptyText: "")
    }
}
