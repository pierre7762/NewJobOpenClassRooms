//
//  FavoriteJobOffer.swift
//  NewJob
//
//  Created by Pierre on 07/01/2022.
//

import SwiftUI

struct FavoriteJobOfferView: View {
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                        .ignoresSafeArea()
                    VStack {
                       
          
                    }
                }
//                .navigationBarTitle("Mes annonces selectionnées", displayMode: .inline)
            }
        }
    }
}

struct FavoriteJobOffer_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteJobOfferView()
    }
}
