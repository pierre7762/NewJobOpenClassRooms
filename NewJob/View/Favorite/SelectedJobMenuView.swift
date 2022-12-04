//
//  SelectedJobMenuView.swift
//  NewJob
//
//  Created by Pierre on 25/04/2022.
//

import SwiftUI

struct SelectedJobMenuView: View {
    var job: SelectedJob
    var jobId: String
    enum PageSection : String, CaseIterable {
        case actionView = "Candidature"
        case jobView = "Annonce"
    }
    @State var segmentationSelection : PageSection = .actionView
    
    var body: some View {
        VStack {
            Picker("", selection: $segmentationSelection) {
                ForEach(PageSection.allCases, id: \.self) { option in
                    Text(option.rawValue)
                }
            }.pickerStyle(SegmentedPickerStyle())
                .padding()
            switch segmentationSelection {
            case .actionView:
                ActionsToBeTakenOnFavoriteJobView(job: job, jobId: jobId)
                
            case .jobView:
                SelectedJobDetailsView(job: job, index: 0)
            }
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)
        )
        .navigationBarTitle(Text(" "), displayMode:.inline)
        .toolbarBackground(
            Color.white,
            for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct SelectedJobMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedJobMenuView(job: SelectedJob(), jobId: "")
    }
}
