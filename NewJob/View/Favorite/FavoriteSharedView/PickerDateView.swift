//
//  PickerDateView.swift
//  NewJob
//
//  Created by Pierre on 14/10/2022.
//

import SwiftUI

struct PickerDateView: View {
    @State var vm: ActionsToBeTakenOnFavoriteJobViewModel
    var body: some View {
//        DatePicker(
//           "Envoyée le :",
//           selection: $vm.createDateCandidacy,
//           displayedComponents: [.date]
//        )
//        DatePicker(selection: $vm.createDateCandidacy, in: ...Date(), displayedComponents: .date) {
//           Text("Envoyée le :")
//        }
        DatePicker(
                "Envoyée le :",
                selection: $vm.createDateCandidacy,
                displayedComponents: [.date]
            )
        .datePickerStyle(.compact)
    }
}

struct PickerDateView_Previews: PreviewProvider {
    static var previews: some View {
        PickerDateView(vm: ActionsToBeTakenOnFavoriteJobViewModel())
    }
}
