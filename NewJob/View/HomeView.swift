//
//  ContentView.swift
//  NewJob
//
//  Created by Pierre on 07/01/2022.
//

import SwiftUI

struct HomeView: View {
    @State var showUserView = false
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    NavigationLink(
                        destination: ActionToBeTakenView(),
                        label: {
                            ThisWeekCard(selectedJobCount: viewModel.jobsCount, candidacySending: viewModel.jobsWithCandidacyMakeCount)
                                .environmentObject(viewModel)
                        }
                    )
                    
                    Spacer()

                    HStack () {
                        NavigationLink(
                            destination: NewSearchJob(),
                            label: {
                                SquareCard(text: "Chercher", image: "magnifyingglass.circle.fill", size: UIScreen.main.bounds.size.width / 2.5)
                            }
                            
                        )
                    }
                    HStack () {
                        NavigationLink(
                            destination: FavoriteJobOfferListView(),
                            label: {
                                SquareCard(text: "Mes annonces", image: "heart.circle.fill", size: UIScreen.main.bounds.size.width / 2.5)
                            }
                        )
                        .isDetailLink(false)
                    }
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement:.navigationBarTrailing) {
                }
            }
            .onAppear(){
                viewModel.updateData()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
                .previewDevice("iPhone 13")
            //            HomeView()
            //                .previewDevice("iPad Pro (9.7-inch)")
        }
    }
}
