//
//  FavoriteJobOffer.swift
//  NewJob
//
//  Created by Pierre on 07/01/2022.
//

import SwiftUI

struct FavoriteJobOfferView: View {
    @ObservedObject var viewModel = FavoriteJobViewModel()
    
    init() {
        UITableView.appearance().backgroundColor = .init(white: 1.0, alpha: 0.0)
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)

                VStack {
                    List {
                        ForEach(viewModel.jobs, id: \.self) { job in
                            NavigationLink(
//                                destination: SelectedJobDetailsView(job: job, index: 0),
                                destination: SelectedJobMenuView(job: job, index: 0),
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
                                    .frame(width: geometry.size.width * 0.8, alignment: .leading)
  
                                    .background(Color(white: 1.0))
                                }
                            )
                        }
                        .onDelete(perform: delete)
                    }
                    
                }
            }
            .navigationBarTitle(Text("Mes annonces sélectionnées"), displayMode:.inline)
          
        }
        .onAppear(){
            viewModel.fetchSelectedJobs()
        }
    }
    
    func delete(offsets: IndexSet) {
        for off in offsets {
//            contactsVM.delete(index: off)
            viewModel.delete(index: off)
        }
    }
}

struct FavoriteJobOffer_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteJobOfferView()
    }
}
