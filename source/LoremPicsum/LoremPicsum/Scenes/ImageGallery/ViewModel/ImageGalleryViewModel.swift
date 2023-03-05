//
//  ImageGalleryViewModel.swift
//  LoremPicsum
//
//  Created by Ravindran on 05/03/23.
//

import Foundation
import SwiftUI

@MainActor class ImageGalleryViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    private var apiService: ImageServiceProtocol
    private let pageLimit: Int = 30
    private var currentPage: Int = 1
    @Published var images: [ImageElement] = []
    @Published var showAlert: Bool = false
    @Published var selectedImage: ImageElement?
    var alertTitle: String = ""
    var alertMessage: String = ""
    
    init(apiService: ImageServiceProtocol) {
        self.apiService = apiService
    }
    
    func loadMoreContent(element: ImageElement) async {
        if let index: Int = images.firstIndex(where: { $0.id == element.id }), index == images.count - 1 {
            await getImageData(loadNextPage: true)
        }
    }
    
    func getImageData(refresh: Bool = false, loadNextPage: Bool = false) async {
        if refresh {
            images.removeAll()
            currentPage = 0
        }
        if loadNextPage {
            currentPage += 1
        } else {
            isLoading = true
        }
        do {
            if let (data, _) = try await apiService.getImageList(pageNumber: currentPage, limit: pageLimit) {
                let model: [ImageElement] = try JSONDecoder().decode([ImageElement].self, from: data)
                if images.isEmpty {
                    images = model
                } else {
                    images.append(contentsOf: model)
                }
                self.isLoading = false
            }
        } catch {
            self.showAlert = true
            self.alertTitle = "Error"
            self.alertMessage = error.localizedDescription
            self.isLoading = false
        }
    }
    
    func getImageUrl(element: ImageElement) -> String {
        return APIEndPoints.ImageData.imageUrl(id: element.id ?? "", width: 100, height: 100).url
    }
}
