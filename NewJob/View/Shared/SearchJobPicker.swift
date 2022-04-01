//
//  SearchJobPicker.swift
//  NewJob
//
//  Created by Pierre on 01/04/2022.
//

import SwiftUI

struct SearchJobPicker: View {
    var searchJobPickerType: searchJobPickerEnum
    @State var newSearchJob: NewSearchJobViewModel
    var body: some View {
        HStack {
            switch searchJobPickerType {
            case .experience:
                Text("Expérience : ")
                    .font(.body)
                Picker("experience", selection: $newSearchJob.search.experience) {
                    Text("Non précisé").tag("")
                    Text("Moins d'un an").tag("1")
                    Text(" De 1 à 3 ans").tag("2")
                    Text("Plus de 3 ans").tag("3")
                }
                .pickerStyle(.menu)
                .onChange(of: newSearchJob.search.experience) { newValue in
                    newSearchJob.search.experience = newValue
                }
            case .qualifcations:
                Text("Qualifications : ")
                    .font(.body)
                Picker("qualification", selection: $newSearchJob.search.qualification) {
                    Text("Non précisé").tag("X")
                    Text("Non cadre").tag("0")
                    Text("Cadre").tag("9")
                }
                .onChange(of: newSearchJob.search.qualification) { newValue in
                    print(newValue)
                    newSearchJob.search.qualification = newValue
                }
                .pickerStyle(.menu)
            }
        }
        
    }
}

struct SearchJobPicker_Previews: PreviewProvider {
    static var previews: some View {
        SearchJobPicker(searchJobPickerType: .qualifcations, newSearchJob: NewSearchJobViewModel())
    }
}

enum searchJobPickerEnum {
    case experience, qualifcations
}
