//
//  SearchJobTextFieldView.swift
//  NewJob
//
//  Created by Pierre on 07/01/2022.
//

import SwiftUI

struct SearchJobTextFieldView: View {
    @State var text: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                    .ignoresSafeArea()
                
            }
        }
    }
}

struct SearchJobTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        SearchJobTextFieldView()
    }
}
