//
//  HomeView.swift
//  WatchNewJob Watch App
//
//  Created by Pierre on 02/02/2023.
//

import SwiftUI

struct HomeView: View {
    let pm = PersistenceManager()
    @State var info: String = ""
    var body: some View {
        VStack{
            Text(info)
        }
        .onAppear(){
            let allCandidacies = pm.fetchAllCandidacies()
            print(allCandidacies)
            let num = allCandidacies.count
            info = "test : \(num)"
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
