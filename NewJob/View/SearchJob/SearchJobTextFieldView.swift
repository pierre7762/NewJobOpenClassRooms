//
//  SearchJobTextFieldView.swift
//  NewJob
//
//  Created by Pierre on 07/01/2022.
//

import SwiftUI

struct SearchJobTextFieldView: View {
    @State var text: String = ""

    private let poleEmploiService = PoleEmploiService()
    
    private func test () {
//        print("test")
        poleEmploiService.getPoleEmploiToken {  result in
            switch result {
            case .success(let tokenApi) :
                print("tokenApi : \(tokenApi)")
            case .failure(_):
                print("failure")
                break
            }
            

        }
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                    .ignoresSafeArea()
                VStack {
                    
//                    Text("Texte entré : \(text)")
                    Text("Texte entré : \(text)")
                                TextField("Entrez du Texte", text: $text)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                    Button("Rechercher", action: test )
                        .frame(width: 100, height: 50, alignment: .center)
                        .background()
                        .cornerRadius(12)
                    
                    Spacer()
                    
                    
                }
            }
        }
    }
}

struct SearchJobTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        SearchJobTextFieldView()
    }
}
