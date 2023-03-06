//
//  ImageGalleryViewModelTests.swift
//  LoremPicsumTests
//
//  Created by Ravindran on 06/03/23.
//

import XCTest
@testable import LoremPicsum

final class ImageGalleryViewModelTests: XCTestCase {
    
    var apiService: MockImageService?
    var imageGalleryViewModel: ImageGalleryViewModel?
    var imageGalleryView: ImageGalleryView?
    
    @MainActor override func setUpWithError() throws {
        try? super.setUpWithError()
        apiService = MockImageService()
        if let confirmedAPIService: MockImageService = apiService {
            imageGalleryViewModel = ImageGalleryViewModel(apiService: confirmedAPIService)
        }
        if let confirmedViewModel: ImageGalleryViewModel = imageGalleryViewModel {
            imageGalleryView = ImageGalleryView(viewModel: confirmedViewModel)
        }
    }
    
    override func tearDownWithError() throws {
        try? super.tearDownWithError()
    }
    
    @MainActor func testViewModel() async throws {
        if let confirmedViewModel: ImageGalleryViewModel = imageGalleryViewModel {
            XCTAssertTrue(confirmedViewModel.images.isEmpty)
            await confirmedViewModel.getImageData()
            XCTAssertTrue(!confirmedViewModel.images.isEmpty)
            if let confirmedElement: ImageElement = confirmedViewModel.images.last {
                await confirmedViewModel.loadMoreContent(element: confirmedElement)
            }
            XCTAssertTrue(!confirmedViewModel.images.isEmpty)
            await confirmedViewModel.getImageData(loadNextPage: true)
            XCTAssertTrue(!confirmedViewModel.images.isEmpty)
        }
    }
}
