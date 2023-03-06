//
//  ImageGalleryView.swift
//  LoremPicsum
//
//  Created by Ravindran on 05/03/23.
//

import SwiftUI

struct ImageGalleryView: View {
    
    @ObservedObject var viewModel: ImageGalleryViewModel
    @State var showImageDetail: Bool = false
    var threeColumnGrid: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    init(viewModel: ImageGalleryViewModel) {
        self.viewModel = viewModel
    }
    
    var loader: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
            .padding()
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("Gallery")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    var gridView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: threeColumnGrid, spacing: 10) {
                ForEach(viewModel.images, id: \.self) { imageElement in
                    ImageElementView(imageElement: imageElement)
                        .onAppear {
                            Task {
                                await viewModel.loadMoreContent(element: imageElement)
                            }
                        }
                        .onTapGesture {
                            viewModel.selectedImage = imageElement
                            self.showImageDetail = true
                        }
                }
            }
        }
        .refreshable {
            Task {
                await viewModel.getImageData(refresh: true)
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Gallery")
        .navigationBarTitleDisplayMode(.inline)
    }
    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                loader
            } else {
                gridView
            }
        }.onAppear {
            Task {
                await viewModel.getImageData()
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(viewModel.alertTitle), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK"), action: {
                viewModel.showAlert = false
                viewModel.alertMessage = ""
            }))
        }
        .sheet(isPresented: $showImageDetail) {
            ImageViewerView(viewModel: ImageViewerViewModel(image: viewModel.selectedImage))
                .onDisappear {
                    viewModel.selectedImage = nil
                }
        }
    }
    
}
