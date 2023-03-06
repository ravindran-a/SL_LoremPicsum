//
//  ImageViewerViewModel.swift
//  LoremPicsum
//
//  Created by Ravindran on 06/03/23.
//

import Foundation
import SwiftUI

@MainActor class ImageViewerViewModel: ObservableObject {
    
    var image: ImageElement?
    @Published var isFavourite: Bool = false
    
    init(image: ImageElement? = nil) {
        self.image = image
    }
    
    func getImageUrl() -> String? {
        return APIEndPoints.ImageData.imageUrl(id: image?.id ?? "", width: 300, height: 300).url
    }
    
    func getImageId() -> String? {
        return image?.id
    }
    
    func getImageAuthor() -> String? {
        return image?.author
    }
    
    func isImageInfavourites() -> Bool {
        guard let confirmedImage: ImageElement = image else {
            return false
        }
        return FavouritesManager.shared.isFavouriteImage(confirmedImage)
    }
    
    func updateFavourite() {
        guard let confirmedImage: ImageElement = image else {
            return
        }
        FavouritesManager.shared.updateFavouriteItem(confirmedImage)
        isFavourite = isImageInfavourites()
    }
    
}
