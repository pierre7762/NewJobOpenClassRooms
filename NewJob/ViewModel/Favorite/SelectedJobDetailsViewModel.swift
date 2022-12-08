//
//  SelectedJobDetailsViewModel.swift
//  NewJob
//
//  Created by Pierre on 25/04/2022.
//

import CoreLocation

class SelectedJobDetailsViewModel: ObservableObject  {
    // MARK: Internal var
    @Published var showAllDescription: Bool = false
    @Published var showingDeleteSheet = false
    @Published var jobLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 48.855045, longitude: 2.342524)
    var favoriteJobList: [SelectedJob] = []
    var job: SelectedJob?
    var pm: PersistenceManager!
    
    func modifyShowAllDescription() {
        showAllDescription = !showAllDescription
    }
    
    func deleteThisFavorite(selectedJobId: String) {
        pm.removeSelectedJob(selectedJobId: selectedJobId)
    }
    
}
