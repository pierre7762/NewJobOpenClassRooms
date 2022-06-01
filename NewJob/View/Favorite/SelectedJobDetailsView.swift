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
    @ObservedObject private var viewModel = SelectedJobDetailsViewModel()
    var job: SelectedJob
    var index: Int
    @State private var coordinate = CLLocationCoordinate2D(latitude: 48.855045, longitude: 2.342524)
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.855045 , longitude: 2.342524), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @State var showAction = false
    @State var font: Font = Font.system(.title)
    @State private var showWebView = false
    @State private var showingAlert = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {

                LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)


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
                                               .frame(width: geometry.size.width * 0.7, height: geometry.size.width * 0.3, alignment: .center)
                                               .cornerRadius(12)
                                       }).actionSheet(isPresented: $showAction) {
                                           ActionSheet(
                                               title: Text("Voulez-vous obtenir un itinéraire ?"),
                                               buttons: [
                                                   .default(Text("Allons-y !"), action: {
                                                       viewModel.openMapForPlace(coordinates: CLLocationCoordinate2D(latitude: job.workplace!.latitude , longitude: job.workplace!.longitude), name: job.entitled ?? "Localisation du poste")
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
                            Button {
                                showWebView.toggle()
                            } label: {
                                Text("Lien vers l'annonce")
                                    .underline()
                            }
                            .sheet(isPresented: $showWebView) {
                                WebView(url: URL(string: job.originOffers!.urlOrigin!)!)
                            }
                        }
                        
//                        JobDetailsInfo(jobDetailsViewModel: jobDetailsViewModel, job: job)
                        
                        Text("Description")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 20))
                        if viewModel.showAllDescription {
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
                                viewModel.modifyShowAllDescription()
                                    }, label: {
                                        if viewModel.showAllDescription {
                                            Label("Reduire", systemImage: "arrow.up.circle")
                                        } else {
                                            Label("Voir tout", systemImage: "arrow.down.circle")
                                        }

                                    })

                            Spacer()
                        }
                    }

                }
                .frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.95, alignment: .leading)
                .background(Color(white: 1.0))
                .cornerRadius(12)


            }
//            .navigationBarTitle(Text(job.entitled?.capitalized ?? ""), displayMode:.inline)
            .toolbar{
                ToolbarItem(placement: .automatic) {
                    Button {
                        if viewModel.isFavorite {
                            showingAlert.toggle()
                        }
                    } label: {
                        Image(systemName: "heart.fill")
                    }
                }
            }
            .onAppear {
                viewModel.job = job
                viewModel.checkIfIsFavorite()
                print(job)
            }
            .alert("Supprimer l'annonce de mes favoris ?", isPresented: $showingAlert) {
                Button("Annuler", role: .cancel) { }
                Button {
                    viewModel.deleteThisFavorite(index: index)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Supprimer")
                }

                    }
        }
    }
}

//struct SelectedJobDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectedJobDetailsView()
//    }
//}
