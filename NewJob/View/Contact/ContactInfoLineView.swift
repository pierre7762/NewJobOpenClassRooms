//
//  ContactInfoLineView.swift
//  NewJob
//
//  Created by Pierre on 02/09/2022.
//

import SwiftUI

struct ContactInfoLineView: View {
    @ObservedObject var vm = ContactDisplayableViewModel()
    var text: String
    var iconName: String
    var clickableType: ClickableType
    var linkString: String = ""
    
    var body: some View {
        HStack{
            Image(systemName: iconName)
                .foregroundColor(.black)
                .font(.system(size: 30))
            Text(text)
                .foregroundColor(.black)
            Button(action: {
                            let phone = "mailto://"
                            let phoneNumberformatted = phone + "pierre.lemere@gmail.com"
                            guard let url = URL(string: phoneNumberformatted) else { return }
                            UIApplication.shared.open(url)
                           }) {
                           Text("la")
                            .foregroundColor(.blue)
                        }
        }
        .onAppear() {
           vm.getClickableString(clickableType: clickableType, text: text)
        }
    }
}
struct ContactInfoLineView_Previews: PreviewProvider {
    static var previews: some View {
        ContactInfoLineView(text: "Text", iconName: "mail", clickableType: .email)
            .previewLayout(.sizeThatFits)
            
    }
}
