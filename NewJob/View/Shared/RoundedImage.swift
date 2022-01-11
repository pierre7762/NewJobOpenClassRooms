//
//  RoundedImage.swift
//  NewJob
//
//  Created by Pierre on 07/01/2022.
//

import SwiftUI

struct RoundedImage: View {
    var imageName: String
    var height: CGFloat
    var width: CGFloat
    var body: some View {
        Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height, alignment: .center)
                    .clipShape(Circle())
                    .shadow(color: .black, radius: 10, x: 1, y: 3)
    }
}

struct RoundedImage_Previews: PreviewProvider {
    static var previews: some View {
        RoundedImage(imageName:"alternanceImage", height: 100, width: 100).previewLayout(.sizeThatFits)
    }
}
