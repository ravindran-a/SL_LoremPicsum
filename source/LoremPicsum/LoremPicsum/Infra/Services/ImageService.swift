//
//  ImageService.swift
//  LoremPicsum
//
//  Created by Ravindran on 05/03/23.
//

import Foundation

class ImageService: ImageServiceProtocol {
    func getImageList(pageNumber: Int, limit: Int) async throws -> (Data, URLResponse)? {
        let url: String = APIEndPoints.ImageData.imageList(pageNumber: pageNumber, limit: limit).url
        return try await APIManager.shared.request(serviceURL: url)
    }
}
