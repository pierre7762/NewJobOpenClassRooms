//
//  SquareCard.swift
//  NewJob
//
//  Created by Pierre on 07/01/2022.
//

import SwiftUI

struct SquareCard: View {
    var text: String
    var image: String
    var size: CGFloat
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size / 3)
                .padding(.all, 5)
                .foregroundColor(.black)
            
            Text(text)
                .font(.system(size: 16, weight: .semibold, design: .default))
                .foregroundColor(.black)
            
        }.frame(width: size, height: size, alignment: .center)
            .background(Color(red: 1, green: 1, blue: 1))
            .cornerRadius(15)
            .padding(.all, 10)
            .shadow(color: Color.gray.opacity(0.2), radius: 15, x: 0, y: 0)
            
            
    }
}

struct SquareCard_Previews: PreviewProvider {
    static var previews: some View {
        SquareCard(text: "Chercher", image: "magnifyingglass.circle.fill", size: 120)
            .previewDevice("iPhone 13").previewLayout(.sizeThatFits)
    }
}
