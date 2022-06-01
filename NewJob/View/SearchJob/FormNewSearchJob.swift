//
//  FormNewSearchJob.swift
//  NewJob
//
//  Created by Pierre on 01/04/2022.
//

import SwiftUI

struct FormNewSearchJob: View {
    @State var viewModel: NewSearchJobViewModel
    
    var body: some View {
        VStack {
            Text("Poste recherché ")
                .fontWeight(.bold)
                .font(.title)
                .foregroundColor(.white)
                .background(Color( white: 1.0, opacity: 0))
//                        .padding()
            Form {

                Section(header: Text("Intitulé du poste"))  {
                    TextField("Entrez un poste", text: $viewModel.search.jobTitle)
                    CustomTextFieldWithDeleteCross(customTextfieldCase: .city, newSearch: viewModel)
                    
                }
//                if viewModel.showCitys {
//                    VStack(alignment: .leading) {
//                        ForEach(viewModel.citys) { city in
//                            Button("\(city.name)(\(city.deptCode))", action: {
//                                viewModel.updateCodeInsee(codeInsee: city.codeInsee, name: city.name)
//                            })
//                                .padding()
//                        }
//                    }
//                }

                
                
                Section(header: Text("Infos"))  {
                    SearchJobPicker(searchJobPickerType: .experience, newSearchJob: viewModel)
                    SearchJobPicker(searchJobPickerType: .qualifcations, newSearchJob: viewModel)
                    
                }
            }

    }
}

struct FormNewSearchJob_Previews: PreviewProvider {
    static var previews: some View {
        FormNewSearchJob(viewModel: NewSearchJobViewModel())
    }
}}
