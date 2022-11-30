//
//  WeekCardLigne.swift
//  NewJob
//
//  Created by Pierre on 24/11/2022.
//

import SwiftUI

struct WeekCardLigne: View {
    var title: String
    var value: Int
    var body: some View {
        HStack {
            Text("\(title) : ")
                .font(.system(size: 16, weight: .semibold, design: .default))
                .foregroundColor(.black)
            Spacer()
            Text("\(value)")
                .font(.system(size: 16, weight: .semibold, design: .default))
                .foregroundColor(.black)
        }
    }
}

struct WeekCardLigne_Previews: PreviewProvider {
    static var previews: some View {
        WeekCardLigne(title: "", value: 0)
    }
}
