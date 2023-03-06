//
//  HomeView.swift
//  LoremPicsum
//
//  Created by Ravindran on 05/03/23.
//

import SwiftUI

struct HomeView: View {
    
    @State var tabSelection: Int = 0
    
    var body: some View {
        TabView(selection: $tabSelection) {
            ImageGalleryView(viewModel: ImageGalleryViewModel(apiService: ImageService()))
                .tabItem {
                    if let confirmedImage: UIImage = UIImage(named: "home") {
                        Image(uiImage: confirmedImage)
                    }
                    Text("Gallery")
                }.tag(0)
            FavouriteView(viewModel: FavouriteViewModel())
                .tabItem {
                    if let confirmedImage: UIImage = UIImage(named: "favourite") {
                        Image(uiImage: confirmedImage)
                    }
                    Text("Favourites")
                }.tag(1)
        }
    }
}
