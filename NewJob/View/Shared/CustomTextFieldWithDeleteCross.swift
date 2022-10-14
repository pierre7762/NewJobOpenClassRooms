//
//  CustomTextFieldWithDeleteCross.swift
//  NewJob
//
//  Created by Pierre on 01/04/2022.
//

import SwiftUI

struct CustomTextFieldWithDeleteCross: View {
    var customTextfieldCase: CustomTextfieldEnum
    @State var newSearch: NewSearchJobViewModel
    
    var body: some View {
        HStack() {
            switch customTextfieldCase {
            case .jobTitle:
                TextField("Entrez un poste", text: $newSearch.search.jobTitle, onCommit: {
                    //Action quand le clavier rentre (fin d'édition)
                    
                })
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .submitLabel(.done)
                                            
//                Button(
//                    action: {
//                        newSearch.search.jobTitle = ""
//                    },
//                    label: {
//                        Image(systemName: "delete.left")
//                    }
//                )
                
            case .city:
                TextField("Ville ", text: $newSearch.search.city, onCommit: {
                    // Action a faire quand l'édition change (début ou fin)
                    newSearch.fetchCityCodeFromCityName()
                })
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                            
//                Button(
//                    action: {
//                        newSearch.search.city = ""
//                    },
//                    label: {
//                        Image(systemName: "delete.left")
//                    }
//                )
            }
            
        }
    }
}

struct CustomTextFieldWithDeleteCross_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextFieldWithDeleteCross(customTextfieldCase: .jobTitle, newSearch: NewSearchJobViewModel())
    }
}

enum CustomTextfieldEnum{
    case jobTitle
    case city
}
