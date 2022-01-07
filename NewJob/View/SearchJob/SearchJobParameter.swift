//
//  SearchJobParameter.swift
//  NewJob
//
//  Created by Pierre on 07/01/2022.
//

import SwiftUI

struct SearchJobParameter: View {
    @State var text: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                    .ignoresSafeArea()
                VStack {
                    Text("Texte entré : \(text)")
                                TextField("Entrez du Texte", text: $text)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
        }
    }
}

struct SearchJobParameter_Previews: PreviewProvider {
    static var previews: some View {
        SearchJobParameter()
    }
}
