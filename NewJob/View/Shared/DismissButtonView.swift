//
//  DismissButtonView.swift
//  NewJob
//
//  Created by Pierre on 09/12/2022.
//

import SwiftUI

struct DismissButtonView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        HStack() {
            Spacer()
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
            }
            .padding()
            .cornerRadius(12)
        }
    }
}

struct DismissButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DismissButtonView()
    }
}
