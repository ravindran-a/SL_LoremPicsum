//
//  FavouriteViewModelTest.swift
//  LoremPicsumTests
//
//  Created by Ravindran on 06/03/23.
//

import XCTest
@testable import LoremPicsum

final class FavouriteViewModelTest: XCTestCase {

    var favouriteViewModel: FavouriteViewModel?
    var favouriteView: FavouriteView?
    
    @MainActor override func setUpWithError() throws {
        try? super.setUpWithError()
        let testData: [ImageElement] = [ImageElement(id: "0", author: "", width: 100, height: 100, url: "", downloadURL: ""),
                        ImageElement(id: "1", author: "", width: 100, height: 100, url: "", downloadURL: "")]
        FavouritesManager.shared.updateFavouriteList(testData)
        favouriteViewModel = FavouriteViewModel()
        if let confirmedViewModel: FavouriteViewModel = favouriteViewModel {
            favouriteView = FavouriteView(viewModel: confirmedViewModel)
        }
    }

    override func tearDownWithError() throws {
        try? super.tearDownWithError()
    }
    
    @MainActor func testFavouritesViewModel() throws {
        if let confirmedViewModel: FavouriteViewModel = favouriteViewModel {
            XCTAssertTrue(confirmedViewModel.getImagesCount() == 2)
            XCTAssertFalse(confirmedViewModel.isEmptyData())
            XCTAssertNotNil(confirmedViewModel.getImage(index: 0))
            XCTAssertNotNil(confirmedViewModel.getImageUrl(index: 0))
            confirmedViewModel.updateFavourite(index: 0)
            confirmedViewModel.setData()
            confirmedViewModel.updateData()
        }
    }
}
