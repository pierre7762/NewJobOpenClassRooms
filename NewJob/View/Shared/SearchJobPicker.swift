//
//  SearchJobPicker.swift
//  NewJob
//
//  Created by Pierre on 01/04/2022.
//

import SwiftUI

struct SearchJobPicker: View {
    var searchJobPickerType: searchJobPickerEnum
    @ObservedObject  var newSearchJob: NewSearchJobViewModel
    var body: some View {
        HStack {
            switch searchJobPickerType {
            case .experience:
                Picker("Expérience", selection: $newSearchJob.search.experience) {
                    Text("Non précisé").tag("Non précisé")
                    Text("Moins d'un an").tag("1")
                    Text("De 1 à 3 ans").tag("2")
                    Text("Plus de 3 ans").tag("3")
                }
                .pickerStyle(.menu)
                
//                .onChange(of: newSearchJob.searchExperienceSelected { newValue in
//                    newSearchJob.searchExperienceSelected = newValue
//                }
            case .qualifcations:
                Picker("Qualification", selection: $newSearchJob.search.qualification) {
                    Text("Non précisé").tag("x")
                    Text("Non cadre").tag("0")
                    Text("Cadre").tag("9")
                }
                .onChange(of: newSearchJob.search.qualification) { newValue in
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
