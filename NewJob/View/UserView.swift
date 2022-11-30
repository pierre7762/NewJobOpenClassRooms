//
//  UserView.swift
//  NewJob
//
//  Created by Pierre on 07/01/2022.
//

import SwiftUI

struct UserView: View {
    @Environment(\.presentationMode) var pres
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.indigo,.cyan,.mint, .green]), startPoint: .topTrailing, endPoint: .bottomLeading)
                    .ignoresSafeArea()
                VStack {
                    
                    
                }
            }
            //                .navigationBarTitle("Mon compte", displayMode: .large)
            //                .toolbar {
            //                  
            //                    ToolbarItem(placement:.navigationBarTrailing) {
            //                        Button(action: {
            ////                            self.pres.wrappedValue.dismiss()
            //                        },
            //                        label: {
            //                            Label("", systemImage: "pencil.circle")
            //                                .foregroundColor(.white)
            //                                .font(.title)
            //                        })
            //                    }
            //                }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
