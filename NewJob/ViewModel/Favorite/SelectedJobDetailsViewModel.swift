//
//  SelectedJobDetailsViewModel.swift
//  NewJob
//
//  Created by Pierre on 25/04/2022.
//

import CoreLocation
import MapKit

class SelectedJobDetailsViewModel: ObservableObject  {
    // MARK: Internal var
    @Published var showAllDescription: Bool = false
    @Published var showingDeleteSheet = false
    @Published var jobLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 48.855045, longitude: 2.342524)
    var favoriteJobList: [SelectedJob] = []
    var job: SelectedJob?

//    var pm = PersistenceManager(coreDataStack: CoreDataStack(modelName: "NewJob"))
//    var pm = PersistenceManager()
    var pm: PersistenceManager!
    
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
    
//    func checkIfIsFavorite() {
//        isFavorite = pm.checkIfIsFavoriteSelectedJob(job: job!)
//    }
    
    func deleteThisFavorite(selectedJobId: String) {
        pm.removeSelectedJob(selectedJobId: selectedJobId)
    }
    
}
