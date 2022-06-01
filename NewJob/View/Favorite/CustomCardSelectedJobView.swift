//
//  CustomCardSelectedJobView.swift
//  NewJob
//
//  Created by Pierre on 07/04/2022.
//

import SwiftUI

struct CustomCardSelectedJobView: View {
    var jobs: [SelectedJob]
    var width: Double
    
    var body: some View {
        VStack {
        }
//        VStack {
//            ScrollView(.vertical, showsIndicators: true) {
//                VStack {
//                    ForEach(jobs) { job in
//                        NavigationLink(
//                            destination: SelectedJobDetailsView(job: job, index: <#Int#>),
//                            label: {
//                                VStack(alignment: .leading) {
//                                    HStack(alignment: .lastTextBaseline) {
//                                        Text(job.entitled ?? "")
//                                            .fontWeight(.bold)
//                                            .font(.footnote)
//                                    }
//                                    Text(job.company!.name ?? "")
//                                        .font(.footnote)
//                                        .foregroundColor(.gray)
//                                    Text(job.workplace?.libelle ?? "")
//                                        .font(.footnote)
//                                        .foregroundColor(.gray)
//                                    Spacer()
//                                    Text(job.salary?.libelle ?? "")
//                                        .font(.footnote)
//                                }
//                                .frame(width: width * 0.8, alignment: .leading)
//                                .padding()
//                                .background(Color(white: 1.0))
//                            }
//                        )
//                            .cornerRadius(12)
//                    }
//                }
//            }
//        }
//        .padding(.init(top: 5, leading: 10, bottom: 5, trailing: 10))
    }
}
//
//struct CustomCardSelectedJobView_Previews: PreviewProvider {
//    static var jobs = [SelectedJob()]
//    static var previews: some View {
//        CustomCardSelectedJobView(jobs: jobs, width: 200)
//    }
//}
