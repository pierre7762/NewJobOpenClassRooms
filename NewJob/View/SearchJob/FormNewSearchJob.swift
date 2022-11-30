//
//  FormNewSearchJob.swift
//  NewJob
//
//  Created by Pierre on 01/04/2022.
//

import SwiftUI

struct FormNewSearchJob: View {
    @State var vm: NewSearchJobViewModel
    @FocusState private var cityIsFocused: Bool
    @State private var cityWriten = ""

    
    var body: some View {
        VStack {
            Text("Poste recherché ")
                .fontWeight(.bold)
                .font(.title)
                .foregroundColor(.white)
                .background(Color( white: 1.0, opacity: 0))
            Form {
                Section(header: Text("Intitulé du poste"))  {
                    TextField("Entrez un poste", text: $vm.search.jobTitle)
                    TextField("Entrez une localisation", text: $cityWriten)
                        .focused($cityIsFocused)
                        .onChange(of:  cityWriten) { newValue in
                            vm.fetchCityCodeFromCityName(cityName: cityWriten)
                        }

                    List {
                        ForEach(vm.citys) { item in
                            Button {
                                vm.search.codeInsee = item.codeInsee
                                cityWriten = "\(item.name)(\(item.deptCode))"
                                vm.citys = []
                                cityIsFocused.toggle()
                                
                            } label: {
                                Text("\(item.name)(\(item.deptCode))")
                            }
                        }
                    }
                     
                }
                Section(header: Text("Infos"))  {
                    SearchJobPicker(searchJobPickerType: .experience, newSearchJob: vm)
                    SearchJobPicker(searchJobPickerType: .qualifcations, newSearchJob: vm)
                }
            }
            .cornerRadius(12)
    }
}

struct FormNewSearchJob_Previews: PreviewProvider {
    static var previews: some View {
        FormNewSearchJob(vm: NewSearchJobViewModel())
    }
}}
