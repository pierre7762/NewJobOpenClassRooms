//
//  WeekCardTitle.swift
//  NewJob
//
//  Created by Pierre on 24/11/2022.
//

import SwiftUI

struct WeekCardTitle: View {
    var title: String
    var body: some View {
        HStack(alignment: .lastTextBaseline){
            Text(title)
                .font(.system(size: 26, weight: .bold, design: .default))
                .foregroundColor(.black)
            Spacer()
        }
        .padding(.trailing, 20)
        .padding(.top, 18)
    }
}

struct WeekCardTitle_Previews: PreviewProvider {
    static var previews: some View {
        WeekCardTitle(title: "")
    }
}
