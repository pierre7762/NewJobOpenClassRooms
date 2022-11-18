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

    var memoryManager = PersistenceManager()
    
    init() {
    
    }
    
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
    
    func checkIfIsFavorite(job: Resultat) {
        isFavorite = memoryManager.checkIfIsFavoriteResultat(job: job)
    }
    
    func deleteThisFavorite(index: Int) {
        memoryManager.viewContext.delete(self.favoriteJobList[index])
//        saveData()
        memoryManager.saveData(from: "jobDetailsViewModel deleteThisFavorite() L58")
        isFavorite = false
    }
    
    func prepareSaveJob(job: Resultat) {
        
        let selectedJob = SelectedJob(context: memoryManager.viewContext)
        let workplace = Workplace(context: memoryManager.viewContext)
        workplace.city = job.lieuTravail.commune
        workplace.posteCode = job.lieuTravail.codepostal
        workplace.libelle = job.lieuTravail.libelle
        workplace.longitude = job.lieuTravail.longitude ?? 0.0
        workplace.latitude = job.lieuTravail.latitude ?? 0.0

        let originOffers = OriginOffers(context: memoryManager.viewContext)
        originOffers.origin = job.origineOffre.origine
        originOffers.urlOrigin = job.origineOffre.urlOrigine
        originOffers.partnerName = job.origineOffre.partenaires[0].nom
        originOffers.partnerLogo = job.origineOffre.partenaires[0].logo
        originOffers.partnerUrl = job.origineOffre.partenaires[0].url

        let salary = Salary(context: memoryManager.viewContext)
        salary.comment = job.salaire.commentaire
        salary.firstComplement = job.salaire.complement1
        salary.secondComplement = job.salaire.complement2
        salary.libelle = job.salaire.libelle
        
//        let candidacy = Candidacy(context: memoryManager.viewContext)
//        candidacy.candidacyMeans = ""
//        candidacy.comment = ""
//        candidacy.candidacyDate = Date()
        
//        candidacy.

//        let company = Company(context: viewContext)
//        company.adaptedCompany = job.entreprise.entrepriseAdaptee ?? false
//        company.name = job.entreprise.nom
//        company.descriptionCompany = job.entreprise.entrepriseDescription


        selectedJob.id = job.id
        selectedJob.creationDate = job.dateCreation
        selectedJob.appelationWording = job.appellationlibelle
        selectedJob.entitled = job.intitule
        selectedJob.jobDescription = job.resultatDescription
//        selectedJob.candidacyMake = false
        selectedJob.workplace = workplace
        selectedJob.originOffers = originOffers
        selectedJob.salary = salary
//        selectedJob.candidacy = nil
//        selectedJob.company = company

        memoryManager.saveData(from: "jobDetailsViewModel prepareSaveJob() L110")
        checkIfIsFavorite(job: job)
    }
}




