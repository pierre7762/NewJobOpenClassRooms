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
    let pm: PersistenceManager
    var selectedJobCount: Int
    var candidacySending: Int
    @State var vm: ThisWeekCardViewModel = ThisWeekCardViewModel()
       
       var body: some View {
           HStack(alignment: .firstTextBaseline) {
               VStack(alignment: .leading) {

                   WeekCardTitle(title: "Compteur total")
                   WeekCardLigne(title: "Candidadures", value: vm.allCandidacyCount)
                   WeekCardLigne(title: "Entretiens", value: vm.allInterviewsCount)
   
                   WeekCardTitle(title: "Actions de la semaine")

                   WeekCardLigne(title: "Candidatures à relancer", value: vm.candidaciesToBeRelanchThisWeekCount)
                   WeekCardLigne(title: "Suivi de relances", value: vm.relaunchToBeRelanchThisWeekCount)
                   WeekCardLigne(title: "Suivi d'entretiens", value: vm.interviewsToBeRelaunchThisWeekCount)
                  
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
           .onAppear(){
               vm.pm = pm
               vm.updateData()
           }
       }
}

struct ThisWeekCard_Previews: PreviewProvider {
    static var previews: some View {
        ThisWeekCard(pm: PersistenceManager(), selectedJobCount: 5, candidacySending: 2, vm: ThisWeekCardViewModel())
            .previewDevice("iPhone 13").previewLayout(.sizeThatFits)
    }
}
