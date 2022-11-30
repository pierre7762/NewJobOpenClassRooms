//
//  FavoriteJobOffer.swift
//  NewJob
//
//  Created by Pierre on 07/01/2022.
//

import SwiftUI

struct FavoriteJobOfferListView: View {
    @ObservedObject var viewModel = FavoriteJobListViewModel()
    
    init() {
        UITableView.appearance().backgroundColor = .init(white: 1.0, alpha: 0.0)
    }

    var body: some View {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                    .ignoresSafeArea()

                List {
                    ForEach(viewModel.jobs, id: \.self) { job in
                        NavigationLink(
//                            destination:  ActionsToBeTakenOnFavoriteJob(job: job, jobId: job.id!),
                            destination:  SelectedJobMenuView(job: job, jobId: job.id!),
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
                    .onDelete(perform: delete)
                }
                .background(Color.white.opacity(0.0))
                .scrollContentBackground(.hidden)
                
            }
            .onAppear() {
                viewModel.updateJobsList()
            }
            .navigationBarTitle(Text("Mes annonces sélectionnées"), displayMode:.inline)
            .toolbarBackground(
                Color.white,
                for: .navigationBar
            )
            .toolbarBackground(.visible, for: .navigationBar)
    }
    
    func delete(offsets: IndexSet) {
        for off in offsets {
            viewModel.delete(job: viewModel.jobs[off])
        }
    }
}

struct FavoriteJobOfferListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteJobOfferListView()
    }
}
