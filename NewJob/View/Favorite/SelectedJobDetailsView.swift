//
//  SelectedJobDetailsView.swift
//  NewJob
//
//  Created by Pierre on 08/04/2022.
//

import MapKit
import SwiftUI
import WebKit

struct SelectedJobDetailsView: View {
    @ObservedObject private var vm = SelectedJobDetailsViewModel()
    let pm: PersistenceManager
    var job: SelectedJob
    var index: Int
    @State private var coordinate = CLLocationCoordinate2D(latitude: 48.855045, longitude: 2.342524)
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.855045 , longitude: 2.342524), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @State var showAction = false
    @State var font: Font = Font.system(.title)
    @State private var showWebView = false
    @State private var showingAlert = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView() {
                VStack {
                    Text(job.workplace?.libelle ?? "")
                        .font(.footnote)
                        .padding(.init(top: 10, leading: 40, bottom: 0, trailing: 20))
                    if job.workplace?.latitude != nil && job.workplace?.longitude != nil {
                        Button(action: {
                            showAction.toggle()
                        }, label: {
                            Map(coordinateRegion: $mapRegion)
                                .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.width * 0.3, alignment: .center)
                                .cornerRadius(12)
                        }).actionSheet(isPresented: $showAction) {
                            ActionSheet(
                                title: Text("Voulez-vous obtenir un itinéraire ?"),
                                buttons: [
                                    .default(Text("Allons-y !"), action: {
                                        openMapForPlace(coordinates: CLLocationCoordinate2D(latitude: job.workplace!.latitude , longitude: job.workplace!.longitude), name: job.entitled ?? "Localisation du poste")
                                    }),
                                    .cancel()
                                ]
                            )
                        }
                    } else {
                        Text("Erreur coordonnées")
                    }
                }
                Text(job.entitled?.capitalized ?? "erreur")
                    .padding(.init(top: 10, leading: 20, bottom: 5, trailing: 20))
                    .font(.title2)
                    .foregroundColor(.blue)
                
                Divider()
                
                
                if (job.originOffers?.urlOrigin != nil) {
                    Link("Lien vers l'annonce", destination: URL(string: job.originOffers!.urlOrigin!)!)
                        .underline()
                }
                
                Text("Description")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 20))
                if vm.showAllDescription {
                    ScrollView() {
                        
                        
                        Text(job.jobDescription ?? "")
                            .font(.body)
                            .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 20))
                        
                        
                    }
                } else {
                    VStack {
                        Text(job.jobDescription ?? "")
                            .font(.body)
                            .padding(.init(top: 10, leading: 20, bottom: 5, trailing: 20))
                            .lineLimit(10)
                    }
                    
                }
                HStack() {
                    Spacer()
                    Button(action: {
                        vm.modifyShowAllDescription()
                    }, label: {
                        if vm.showAllDescription {
                            Label("Reduire", systemImage: "arrow.up.circle")
                        } else {
                            Label("Voir tout", systemImage: "arrow.down.circle")
                        }
                        
                    })
                    
                    Spacer()
                }
            }
            .padding(12)
            
        }
        .background(Color(white: 1.0))
        .cornerRadius(12)
        .onAppear {
            vm.pm = pm
            vm.job = job
//            vm.checkIfIsFavorite()
        }
        .navigationBarTitle(Text(" "), displayMode:.inline)
        .toolbarBackground(
            Color.white,
            for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            Button {
                vm.showingDeleteSheet.toggle()
            } label: {
                Image(systemName: "trash")
                    .foregroundColor(.red)
                    .frame(width: 50, height: 50)
            }
        }
        .alert(isPresented: $vm.showingDeleteSheet) {
            Alert(
                title: Text("Supprimer l'offre ?"),
                primaryButton: .destructive(Text("Supprimer"), action: {
                    vm.deleteThisFavorite(selectedJobId: job.id!)
                    self.presentationMode.wrappedValue.dismiss()
                }),
                secondaryButton: .default(Text("Annuler"), action: {
                    vm.showingDeleteSheet.toggle()
                })
            )
        }
    }
    
}

//struct SelectedJobDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectedJobDetailsView()
//    }
//}
