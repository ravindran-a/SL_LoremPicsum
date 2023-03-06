//
//  ImageViewerViewModelTests.swift
//  LoremPicsumTests
//
//  Created by Ravindran on 06/03/23.
//

import XCTest
@testable import LoremPicsum

final class ImageViewerViewModelTests: XCTestCase {

    var imageViewerViewModel: ImageViewerViewModel?
    var imageViewerView: ImageViewerView?
    
    @MainActor override func setUpWithError() throws {
        try? super.setUpWithError()
        imageViewerViewModel = ImageViewerViewModel(image: ImageElement(id: "0", author: "", width: 100, height: 100, url: "", downloadURL: ""))
        if let confirmedViewModel: ImageViewerViewModel = imageViewerViewModel {
            imageViewerView = ImageViewerView(viewModel: confirmedViewModel)
        }
    }

    override func tearDownWithError() throws {
        try? super.tearDownWithError()
    }

    @MainActor func testImageViewerViewModel() throws {
        if let confirmedViewModel: ImageViewerViewModel = imageViewerViewModel {
            FavouritesManager.shared.updateFavouriteList([])
            XCTAssertNotNil(confirmedViewModel.getImageUrl())
            XCTAssertNotNil(confirmedViewModel.getImageId())
            XCTAssertNotNil(confirmedViewModel.getImageAuthor())
            XCTAssertFalse(confirmedViewModel.isImageInfavourites())
            confirmedViewModel.updateFavourite()
            XCTAssertTrue(confirmedViewModel.isImageInfavourites())
        }
    }
    
}
