//
//  ImageViewerView.swift
//  LoremPicsum
//
//  Created by Ravindran on 05/03/23.
//

import SwiftUI
import UIKit
import Kingfisher
import Combine

struct ImageViewerView: View {
    var image: ImageElement?
    @State var isFavourite: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(image: ImageElement?) {
        self.image = image
    }
    
    var closeButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Close")
        }
    }
    
    var favouriteButton: some View {
        Button {
            updateFavourite()
        } label: {
            HStack {
                if let confirmedImage: UIImage = UIImage(named: isFavourite ? "starFilled" : "starEmpty") {
                    Image(uiImage: confirmedImage)
                }
                Text(isFavourite ? "Remove from Favourites" : "Add to Favourites")
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                if let confirmedImage: String = getImageUrl(), let confirmedUrl: URL = URL(string: confirmedImage) {
                    KFImage(confirmedUrl)
                        .placeholder({
                            Image("placeholder")
                                .resizable()
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                .scaledToFit()
                        })
                        .resizable()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .scaledToFit()
                        .navigationBarBackButtonHidden(true)
                        .navigationBarTitle("Image Viewer")
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarItems(trailing: closeButton)
                }
                favouriteButton
            }
        }.onAppear {
            isFavourite = isImageInfavourites()
        }
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
