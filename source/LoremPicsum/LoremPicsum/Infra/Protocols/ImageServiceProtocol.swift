//
//  ImageServiceProtocol.swift
//  LoremPicsum
//
//  Created by Ravindran on 05/03/23.
//

import Foundation

protocol ImageServiceProtocol {
    func getImageList(pageNumber: Int, limit: Int) async throws -> (Data, URLResponse)?
}
