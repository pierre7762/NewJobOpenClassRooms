//
//  JobDetailsViewModel.swift
//  NewJob
//
//  Created by Pierre on 03/02/2022.
//

import Foundation
import CoreLocation

class JobDetailsViewModel: ObservableObject  {
    // MARK: Internal var
    @Published var showAllDescription: Bool = false
    @Published var isFavorite = false
    @Published var jobLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 48.855045, longitude: 2.342524)
    var favoriteJobList: [SelectedJob] = []

    var pm: PersistenceManager!
    
    func modifyShowAllDescription() {
        showAllDescription = !showAllDescription
    }
    
    func checkIfIsFavorite(job: Resultat) {
        isFavorite = pm.checkIfIsFavoriteResultat(job: job)
    }
    
    func deleteThisFavorite(selectedJobId: String) {
        pm.removeSelectedJob(selectedJobId: selectedJobId)
        isFavorite = false
    }
    
    func prepareSaveJob(job: Resultat) {
        pm.createSelectedJob(job: job)
        checkIfIsFavorite(job: job)
    }
}




