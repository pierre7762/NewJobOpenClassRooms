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
    @Published var isFavorite = false
    @Published var jobLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 48.855045, longitude: 2.342524)
    var favoriteJobList: [SelectedJob] = []
    var job: SelectedJob?

    var memoryManager = PersistenceManager()
    
    func modifyShowAllDescription() {
        showAllDescription = !showAllDescription
    }
    
    func openMapForPlace(coordinates: CLLocationCoordinate2D, name: String) {
        
//        let lat1 : NSString = self.venueLat
//        let lng1 : NSString = self.venueLng
//
//        let latitude:CLLocationDegrees =  lat1.doubleValue
//        let longitude:CLLocationDegrees =  lng1.doubleValue
//
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
    
    func checkIfIsFavorite() {
        isFavorite = memoryManager.checkIfIsFavoriteSelectedJob(job: job!)
    }
    
    func deleteThisFavorite(index: Int) {
        isFavorite = false
        memoryManager.viewContext.delete(self.favoriteJobList[index])
        memoryManager.saveData(from: "selectedJobViewModel deleteThisFavorite() L54")
    }
    
}
