//
//  ImageElementView.swift
//  LoremPicsum
//
//  Created by Ravindran on 05/03/23.
//

import SwiftUI
import Kingfisher

struct ImageElementView: View {
    @State var imageElement: ImageElement
    
    init(imageElement: ImageElement) {
        self.imageElement = imageElement
    }
    
    var body: some View {
        if let url: URL = URL(string: getImageUrl(element: imageElement)) {
            KFImage(url)
                .placeholder({
                    Image("placeholder")
                        .resizable()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .scaledToFit()
                })
                .resizable()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .scaledToFit()
                .cornerRadius(6.0)
        }
    }
    
    func getImageUrl(element: ImageElement) -> String {
        return APIEndPoints.ImageData.imageUrl(id: element.id ?? "", width: 100, height: 100).url
    }
}
