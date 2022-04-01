//
//  FormNewSearchJob.swift
//  NewJob
//
//  Created by Pierre on 01/04/2022.
//

import SwiftUI

struct FormNewSearchJob: View {
    var width: CGFloat
    var height: CGFloat
    @State var newSearchJob: NewSearchJobViewModel
    
    var body: some View {
        VStack {

            VStack (alignment: .leading) {
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
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: ResultNewSearch(newSearch: newSearchJob), isActive: $newSearchJob.showResult) { EmptyView() }
                    if newSearchJob.requestInProgress {
                        ProgressView()
                    } else {
                        Button("Rechercher", action: newSearchJob.getOffersOnPoleEmploi)
                    }
                    
                    Spacer()
                }
            }
            .padding()
            .frame(width: width * 0.9 , height: height * 0.85 , alignment: .leading)
            .background(Color.white)
            .cornerRadius(20)
            
        }
        .padding()
    }
}

struct FormNewSearchJob_Previews: PreviewProvider {
    static var previews: some View {
        FormNewSearchJob(width: 400, height: 300, newSearchJob: NewSearchJobViewModel())
    }
}
