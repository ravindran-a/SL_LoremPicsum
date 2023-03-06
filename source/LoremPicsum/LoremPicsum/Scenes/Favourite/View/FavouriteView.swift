//
//  FavouriteView.swift
//  LoremPicsum
//
//  Created by Ravindran on 05/03/23.
//

import SwiftUI
import Kingfisher

struct FavouriteView: View {
    
    @ObservedObject var viewModel: FavouriteViewModel
    var threeColumnGrid: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @State var showImageDetail: Bool = false
    
    init(viewModel: FavouriteViewModel) {
        self.viewModel = viewModel
    }
    
    var loader: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
            .padding()
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("Favourites")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    var emptyView: some View {
        VStack {
            Text("Add image to your favourites")
        }.padding()
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("Favourites")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    var favouriteView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: threeColumnGrid, spacing: 10) {
                ForEach(viewModel.images, id: \.self) { imageElement in
                    ImageElementView(imageElement: imageElement)
                        .onTapGesture {
                            viewModel.selectedImage = imageElement
                            self.showImageDetail = true
                        }
                }
            }
        }
        .refreshable {
            viewModel.updateData()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Favourites")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showImageDetail) {
            ImageViewerView(viewModel: ImageViewerViewModel(image: viewModel.selectedImage))
                .onDisappear {
                    viewModel.selectedImage = nil
                    viewModel.updateData()
                }
        }
    }
    
    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                loader
            } else {
                if viewModel.images.isEmpty {
                    emptyView
                } else {
                    favouriteView
                }
            }
        }.onAppear {
            viewModel.updateData()
        }
    }
}
