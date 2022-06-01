//
//  SelectedJobMenuView.swift
//  NewJob
//
//  Created by Pierre on 25/04/2022.
//

import SwiftUI

struct SelectedJobMenuView: View {
    var job: SelectedJob
    var index: Int
    
    var body: some View {
        TabView {
            ActionsToBeTakenOnFavoriteJob(job: job)
                .tabItem {
                    Label("Actions", systemImage: "checklist")
                }
            SelectedJobDetailsView(job: job, index: index)
                .tabItem {
                    Label("Annonce", systemImage: "doc.plaintext")
                }
        }
    }
}

struct SelectedJobMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedJobMenuView(job: SelectedJob(), index: 0)
    }
}
