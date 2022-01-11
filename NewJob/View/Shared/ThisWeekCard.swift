//
//  ThisWeekCard.swift
//  NewJob
//
//  Created by Pierre on 07/01/2022.
//

import SwiftUI

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
    
}

struct ThisWeekCard: View {
       
       var body: some View {
           HStack(alignment: .firstTextBaseline) {
               VStack(alignment: .leading) {
                   HStack(alignment: .lastTextBaseline){
                       Text("Cette Semaine")
                           .font(.system(size: 26, weight: .bold, design: .default))
                           .foregroundColor(.black)
                       Spacer()
                   }.padding(.trailing, 20)
                   
                   HStack {
                       Text("Entreprises contactées")
                           .font(.system(size: 16, weight: .semibold, design: .default))
                           .foregroundColor(.black)
                       Spacer()
                       Text("1/10")
                           .font(.system(size: 16, weight: .semibold, design: .default))
                           .foregroundColor(.black)
                   }
                   HStack {
                       Text("Entreprises Relancées")
                           .font(.system(size: 16, weight: .semibold, design: .default))
                           .foregroundColor(.black)
                       Spacer()
                       Text("1/10")
                           .font(.system(size: 16, weight: .semibold, design: .default))
                           .foregroundColor(.black)
                   }
               }
               .padding(.all, 15)
               
               HStack(alignment: .firstTextBaseline) {
                   
                   
               }.padding(.trailing, 20)
               Spacer()
           }
           .frame(maxWidth: .infinity, alignment: .center)
           .background(Color(red: 1, green: 1, blue: 1))
           .modifier(CardModifier())
           .padding(.all, 10)
       }
}

struct ThisWeekCard_Previews: PreviewProvider {
    static var previews: some View {
        ThisWeekCard()
            .previewDevice("iPhone 13").previewLayout(.sizeThatFits)
    }
}
