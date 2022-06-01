//
//  SelectedJobDetailsViewModel.swift
//  NewJob
//
//  Created by Pierre on 25/04/2022.
//

import CoreLocation
import MapKit
import CoreData


class SelectedJobDetailsViewModel: ObservableObject  {
    // MARK: Internal var
    @Published var showAllDescription: Bool = false
    @Published var isFavorite = false
    @Published var jobLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 48.855045, longitude: 2.342524)
    var favoriteJobList: [SelectedJob] = []
    var job: SelectedJob = SelectedJob()

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
        let request = NSFetchRequest<SelectedJob>(entityName: "SelectedJob")
        do {
            self.favoriteJobList = try memoryManager.viewContext.fetch(request)
            print("save job count : ", self.favoriteJobList.count)
            self.favoriteJobList.forEach {
                if $0.originOffers?.urlOrigin == self.job.originOffers?.urlOrigin {
                    isFavorite = true
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteThisFavorite(index: Int) {
        isFavorite = false
        memoryManager.viewContext.delete(self.favoriteJobList[index])
        memoryManager.saveData()
    }
    
}
