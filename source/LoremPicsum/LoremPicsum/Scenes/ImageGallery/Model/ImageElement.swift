//
//  ImageElement.swift
//  LoremPicsum
//
//  Created by Ravindran on 05/03/23.
//

import Foundation

struct ImageElement: Codable, Hashable {
    let id, author: String?
    let width, height: Int?
    let url, downloadURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}
