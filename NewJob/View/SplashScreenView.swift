//
//  SplashScreenView.swift
//  NewJob
//
//  Created by Pierre on 24/11/2022.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive : Bool = false
    @State private var size = 0.4
    @State private var opacity = 0.4
    
    var body: some View {
        if isActive {
            HomeView()
        } else {
            ZStack {
                VStack {
//                    Image("logo")
//                        .font(.system(size: UIScreen.main.bounds.size.width * 0.2))
//                        .foregroundColor(.red)
//                        .cornerRadius(12)

                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.7
                        self.opacity = 1.00
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
