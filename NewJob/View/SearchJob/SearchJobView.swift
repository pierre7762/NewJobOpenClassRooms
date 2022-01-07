//
//  SearchJobView.swift
//  NewJob
//
//  Created by Pierre on 07/01/2022.
//

import SwiftUI

struct SearchJobView: View {
//    @State var selection = 1
    @State var text: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                    .ignoresSafeArea()
                CustomTabView()
//                TabView(selection: $selection,
//                        content:  {
//                            SearchJobParameter()
//                                .tabItem {
//                                    Text("Lièvre")
//                                    Image(systemName: "hare.fill")
//                                }.tag(1)
//                            SearchJobTextFieldView()
//                                .tabItem {
//                                    Text("Tortue")
//                                    Image(systemName: "tortoise.fill")
//                                }.tag(2)
//                        })
            }
        }
    }
}

struct SearchJobView_Previews: PreviewProvider {
    static var previews: some View {
        SearchJobView()
    }
}
