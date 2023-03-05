//
//  FavouritesManager.swift
//  LoremPicsum
//
//  Created by Ravindran on 05/03/23.
//

import Foundation

class FavouritesManager {
    
    static let shared: FavouritesManager = FavouritesManager()
    
    func getListOfFavourites() -> [ImageElement]? {
        if let confirmedObject: [ImageElement] = unArchiveFavouriteImages() {
            return confirmedObject
        }
        return nil
    }
    
    func isFavouriteImage(_ image: ImageElement) -> Bool {
        if let confirmedObject: [ImageElement] = unArchiveFavouriteImages() {
            return confirmedObject.contains(where: { $0.id == image.id })
        }
        return false
    }
    
    func updateFavouriteItem(_ image: ImageElement) {
        if var confirmedObject: [ImageElement] = unArchiveFavouriteImages() {
            if let confirmedIndex: Int = confirmedObject.firstIndex(where: { $0.id == image.id }) {
                confirmedObject.remove(at: confirmedIndex)
                archiveFavouriteImages(confirmedObject)
            } else {
                confirmedObject.append(image)
                archiveFavouriteImages(confirmedObject)
            }
        } else {
            var images: [ImageElement] = [ImageElement]()
            images.append(image)
            archiveFavouriteImages(images)
        }
    }
    
    func updateFavouriteList(_ images: [ImageElement]) {
        archiveFavouriteImages(images)
    }
    
    private func archiveFavouriteImages(_ images: [ImageElement]) {
        let data: Data? = try? JSONEncoder().encode(images)
        UserDefaultsManager.setObject(data, forKey: .favourites)
    }
    
    private func unArchiveFavouriteImages() -> [ImageElement]? {
        if let unarchivedObject: Data = UserDefaultsManager.objectForKey(.favourites) as? Data {
            return try? JSONDecoder().decode([ImageElement].self, from: unarchivedObject)
        }
        return nil
    }
    
}
