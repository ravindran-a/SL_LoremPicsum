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
    
    @ObservedObject var viewModel: ImageViewerViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(viewModel: ImageViewerViewModel) {
        self.viewModel = viewModel
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
            viewModel.updateFavourite()
        } label: {
            HStack {
                if let confirmedImage: UIImage = UIImage(named: viewModel.isFavourite ? "starFilled" : "starEmpty") {
                    Image(uiImage: confirmedImage)
                }
                Text(viewModel.isFavourite ? "Remove from Favourites" : "Add to Favourites")
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                if let confirmedImage: String = viewModel.getImageUrl(), let confirmedUrl: URL = URL(string: confirmedImage) {
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
            viewModel.isFavourite = viewModel.isImageInfavourites()
        }
    }
    
}
