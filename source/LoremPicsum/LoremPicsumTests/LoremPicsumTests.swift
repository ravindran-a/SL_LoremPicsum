//
//  LoremPicsumTests.swift
//  LoremPicsumTests
//
//  Created by Ravindran on 05/03/23.
//

import XCTest
@testable import LoremPicsum

final class LoremPicsumTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testDefaultsManager() throws {
        UserDefaultsManager.setInt(0, forKey: .favourites)
        XCTAssertTrue(UserDefaultsManager.integerForKey(.favourites) == 0)
        
        UserDefaultsManager.setString("test", forKey: .favourites)
        XCTAssertTrue(UserDefaultsManager.stringForKey(.favourites) == "test")
        
        UserDefaultsManager.setBool(true, forKey: .favourites)
        XCTAssertTrue(UserDefaultsManager.boolForKey(.favourites) == true)
        
        UserDefaultsManager.removeAllUserDefaultValues()
        UserDefaultsManager.setString("test", forKey: .favourites)
        UserDefaultsManager.removeValueForKey(.favourites)
    }
    
    func testFavouritesManager() throws {
        let testData: [ImageElement] = [ImageElement(id: "0", author: "", width: 100, height: 100, url: "", downloadURL: ""),
                        ImageElement(id: "1", author: "", width: 100, height: 100, url: "", downloadURL: "")]
        FavouritesManager.shared.updateFavouriteList(testData)
        FavouritesManager.shared.updateFavouriteItem(ImageElement(id: "2", author: "", width: 100, height: 100, url: "", downloadURL: ""))
        XCTAssertTrue(FavouritesManager.shared.getListOfFavourites()?.count == 3)
    }

}
