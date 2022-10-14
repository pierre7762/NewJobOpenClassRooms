//
//  ContactDisplayableViewModel.swift
//  NewJob
//
//  Created by Pierre on 02/09/2022.
//

import Foundation


class ContactDisplayableViewModel: ObservableObject {
    @Published var clickableString: String = ""
    
    func getClickableString(clickableType: ClickableType, text: String) {
        switch clickableType {
        case .phoneNumer:
            clickableString = "tel:\(text)"
        case .email:
            clickableString = "mailto:\(text)"
        }
    }
}

enum ClickableType {
    case phoneNumer
    case email
}
