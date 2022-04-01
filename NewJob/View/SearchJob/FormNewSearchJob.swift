//
//  FormNewSearchJob.swift
//  NewJob
//
//  Created by Pierre on 01/04/2022.
//

import SwiftUI

struct FormNewSearchJob: View {
    @State var newSearchJob: NewSearchJobViewModel
    
    var body: some View {
        HStack() {
            Text("Poste recherché ")
                .fontWeight(.bold)
                .font(.title)
            
            Spacer()
        }
        
        CustomTextFieldWithDeleteCross(customTextfieldCase: .jobTitle, newSearch: newSearchJob)
        CustomTextFieldWithDeleteCross(customTextfieldCase: .city, newSearch: newSearchJob)
        
        if newSearchJob.showCitys {
            VStack(alignment: .leading) {
                ForEach(newSearchJob.citys) { city in
                    Button("\(city.name)(\(city.deptCode))", action: {
                        newSearchJob.updateCodeInsee(codeInsee: city.codeInsee, name: city.name)
                    })
                        .padding()
                }
            }
        }
        
        SearchJobPicker(searchJobPickerType: .experience, newSearchJob: newSearchJob)
        SearchJobPicker(searchJobPickerType: .qualifcations, newSearchJob: newSearchJob)
    }
}

struct FormNewSearchJob_Previews: PreviewProvider {
    static var previews: some View {
        FormNewSearchJob(newSearchJob: NewSearchJobViewModel())
    }
}
