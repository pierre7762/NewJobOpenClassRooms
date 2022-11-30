//
//  JobDetailsViewModel.swift
//  NewJob
//
//  Created by Pierre on 03/02/2022.
//

import Foundation
import CoreLocation
import MapKit

class JobDetailsViewModel: ObservableObject  {
    // MARK: Internal var
    @Published var showAllDescription: Bool = false
    @Published var isFavorite = false
    @Published var jobLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 48.855045, longitude: 2.342524)
    var favoriteJobList: [SelectedJob] = []

    var pm = PersistenceManager(coreDataStack: CoreDataStack(modelName: "NewJob"))
    
    
    func modifyShowAllDescription() {
        showAllDescription = !showAllDescription
    }
    
    func openMapForPlace(coordinates: CLLocationCoordinate2D, name: String) {
        let regionDistance:CLLocationDistance = 10000
        let coordinates = coordinates
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        mapItem.openInMaps(launchOptions: options)
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




