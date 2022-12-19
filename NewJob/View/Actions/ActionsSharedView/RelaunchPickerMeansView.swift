//
//  RelaunchPickerMeansView.swift
//  NewJob
//
//  Created by Pierre on 28/10/2022.
//

import SwiftUI

struct RelaunchPickerMeansView: View {
    @ObservedObject  var vm: RelaunchFormViewModel
    
    var body: some View {
        HStack {
            Picker("Moyen utilisé :", selection: $vm.means) {
                Text("Non précisé").tag("Non précisé")
                Text("Téléphone").tag("Téléphone")
                Text("Mail").tag("Mail")
                Text("Courrier").tag("Courrier")
                Text("Site internet").tag("Site internet")
            }
            .pickerStyle(.menu)
        }
    }
}

struct RelaunchPickerMeansView_Previews: PreviewProvider {
    static var previews: some View {
        RelaunchPickerMeansView(vm: RelaunchFormViewModel())
    }
}
