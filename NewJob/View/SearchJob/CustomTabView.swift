//
//  CustomTabView.swift
//  NewJob
//
//  Created by Pierre on 07/01/2022.
//

import SwiftUI
import UIKit

struct CustomTabView: View {
    @State var selection = 1
    
    init() {
        UITabBar.appearance().barTintColor = .white
    }
    
    var body: some View {
        HStack{
            TabView(selection: $selection,
                    content:  {
                        LastSearchJob()
                            .tabItem {
                                Text("Recherche \n enregistrée")
                                Image(systemName: "arrow.clockwise")
                            }.tag(2)
                        NewSearchJob()
                            .tabItem {
                                Text("Nouvelle recherche")
                                Image(systemName: "magnifyingglass")
                            }.tag(1)
                    }
            ).background(Color.white)
            
        }
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView().previewLayout(.sizeThatFits)
    }
}
