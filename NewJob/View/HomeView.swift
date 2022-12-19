//
//  ContentView.swift
//  NewJob
//
//  Created by Pierre on 07/01/2022.
//

import SwiftUI

struct HomeView: View {
    let pm = PersistenceManager()
    @State var showUserView = false
    @StateObject private var vm = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    NavigationLink(
                        destination: ActionToBeTakenView(pm: pm),
                        label: {
                            ThisWeekCard(pm: pm, selectedJobCount: vm.jobsCount, candidacySending: vm.jobsWithCandidacyMakeCount)
                                .environmentObject(vm)
                        }
                    )
                    
                    Spacer()

                    HStack () {
                        NavigationLink(
                            destination: NewSearchJob(pm: pm),
                            label: {
                                SquareCard(text: "Chercher", image: "magnifyingglass.circle.fill", size: UIScreen.main.bounds.size.width / 2.5)
                            }
                        )
                    }
                    HStack () {
                        NavigationLink(
                            destination: FavoriteJobOfferListView(pm: pm),
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
                vm.pm = pm
                vm.updateData()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
                .previewDevice("iPhone 13")
        }
    }
}
