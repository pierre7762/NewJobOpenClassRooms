//
//  PickerCandidacyMeansView.swift
//  NewJob
//
//  Created by Pierre on 14/10/2022.
//

import SwiftUI

struct PickerCandidacyMeansView: View {
    @ObservedObject var vm: ActionsToBeTakenOnFavoriteJobViewModel
    
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

struct PickerCandidacyMeansView_Previews: PreviewProvider {
    static var previews: some View {
        PickerCandidacyMeansView(vm: ActionsToBeTakenOnFavoriteJobViewModel())
    }
}
