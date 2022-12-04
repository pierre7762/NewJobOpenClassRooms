//
//  JobsInList.swift
//  NewJob
//
//  Created by Pierre on 03/12/2022.
//

import SwiftUI

struct JobsInList: View {
    var jobsList: [SelectedJob]
    var pm: PersistenceManager

    var body: some View {
        List {
            ForEach(jobsList, id: \.self) { job in
                NavigationLink(
                    destination:  SelectedJobMenuView(pm: pm, job: job, jobId: job.id!),
                    label: {
                        VStack(alignment: .leading) {
                            HStack(alignment: .lastTextBaseline) {
                                Text("")
                                Text(job.entitled ?? "")
                                    .fontWeight(.bold)
                                    .font(.footnote)
                            }
                            Text(job.company?.name ?? "")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            Text(job.workplace?.libelle ?? "")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            Spacer()
                            Text(job.salary?.libelle ?? "")
                                .font(.footnote)
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.8, alignment: .leading)
                        .background(Color(white: 1.0))
                    }
                )
            }
        }
        .background(Color.white.opacity(0.0))
        .scrollContentBackground(.hidden)
    }
}

struct JobsInList_Previews: PreviewProvider {
    static var previews: some View {
        JobsInList(jobsList: [], pm: PersistenceManager())
    }
}
