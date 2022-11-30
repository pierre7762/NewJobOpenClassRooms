//
//  RelaunchPickerDateView.swift
//  NewJob
//
//  Created by Pierre on 28/10/2022.
//

import SwiftUI

struct RelaunchPickerDateView: View {
    @State var vm: AddRelaunchViewModel
    var body: some View {
        DatePicker(
                "Envoyée le :",
                selection: $vm.createDateRelaunch,
                displayedComponents: [.date]
            )
        .datePickerStyle(.compact)
    }
}

struct RelaunchPickerDateView_Previews: PreviewProvider {
    static var previews: some View {
        RelaunchPickerDateView(vm: AddRelaunchViewModel())
    }
}
