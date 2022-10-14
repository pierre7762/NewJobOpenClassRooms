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
    var selectedJobCount: Int
    var candidacySending: Int
    @EnvironmentObject var vm: HomeViewModel
       
       var body: some View {
           HStack(alignment: .firstTextBaseline) {
               VStack(alignment: .leading) {
                   HStack(alignment: .lastTextBaseline){
                       Text("Compteur")
                           .font(.system(size: 26, weight: .bold, design: .default))
                           .foregroundColor(.black)
                       Spacer()
                   }.padding(.trailing, 20)
                   
                   HStack {
                       Text("Candidature envoyées : ")
                           .font(.system(size: 16, weight: .semibold, design: .default))
                           .foregroundColor(.black)
                       Spacer()
                       Text("\(candidacySending)")
                           .font(.system(size: 16, weight: .semibold, design: .default))
                           .foregroundColor(.black)
                   }
                   HStack {
                       Text("Contact : ")
                           .font(.system(size: 16, weight: .semibold, design: .default))
                           .foregroundColor(.black)
                       Spacer()
                       Text("\(vm.contactsCount)")
                           .font(.system(size: 16, weight: .semibold, design: .default))
                           .foregroundColor(.black)
                   }
                   
                   HStack(alignment: .lastTextBaseline){
                       Text("Cette Semaine")
                           .font(.system(size: 26, weight: .bold, design: .default))
                           .foregroundColor(.black)
                       Spacer()
                   }.padding(.trailing, 20)
                   
                   HStack {
                       Text("Entreprises à contacter")
                           .font(.system(size: 16, weight: .semibold, design: .default))
                           .foregroundColor(.black)
                       Spacer()
                       Text("\(selectedJobCount)")
                           .font(.system(size: 16, weight: .semibold, design: .default))
                           .foregroundColor(.black)
                   }
                   
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
        ThisWeekCard(selectedJobCount: 5, candidacySending: 2)
            .previewDevice("iPhone 13").previewLayout(.sizeThatFits)
    }
}
