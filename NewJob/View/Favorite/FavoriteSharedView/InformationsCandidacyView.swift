//
//  InformationsCandidacyView.swift
//  NewJob
//
//  Created by Pierre on 14/10/2022.
//

import SwiftUI

struct InformationsCandidacyView: View {
    @ObservedObject var vm: ActionsToBeTakenOnFavoriteJobViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Informations :")
            ZStack {
                TextEditor(text: $vm.comment)
                Text(vm.comment)
                    .opacity(0)
                    .padding(.all, 8)
            }
        }
    }
}

struct InformationsCandidacyView_Previews: PreviewProvider {
    static var previews: some View {
        InformationsCandidacyView(vm: ActionsToBeTakenOnFavoriteJobViewModel())
    }
}
