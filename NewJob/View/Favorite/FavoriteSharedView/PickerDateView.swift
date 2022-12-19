//
//  PickerDateView.swift
//  NewJob
//
//  Created by Pierre on 14/10/2022.
//

import SwiftUI

struct PickerDateView: View {
    @State var typeOfView: TypeOfView
    @State var vm: ActionsToBeTakenOnFavoriteJobViewModel
    var body: some View {
        switch typeOfView{
        case .candidacy:
            DatePicker(
                    "Envoyée le :",
                    selection: $vm.createDateCandidacy,
                    displayedComponents: [.date]
                )
            .datePickerStyle(.compact)
            
        case .interview:
            DatePicker(
                    "Du :",
                    selection: $vm.createDateInterview,
                    displayedComponents: [.date]
                )
            .datePickerStyle(.compact)
            
        }
    }
}

struct PickerDateView_Previews: PreviewProvider {
    static var previews: some View {
        PickerDateView(typeOfView: .candidacy, vm: ActionsToBeTakenOnFavoriteJobViewModel())
    }
}

