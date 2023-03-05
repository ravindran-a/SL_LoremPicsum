//
//  APIEndPoints.swift
//  LoremPicsum
//
//  Created by Ravindran on 05/03/23.
//

import Foundation

enum APIEndPoints {
    
    static let ApiBaseUrl: String = "https://picsum.photos/"
    
    enum ImageData {
        case imageList(pageNumber: Int, limit: Int)
        case imageDetail(id: String)
        case imageUrl(id: String, width: Int, height: Int)

        var url: String {
            switch self {
            case let .imageList(pageNumber, limit):
                return "v2/list?page=\(pageNumber)&limit=\(limit)"
            case let .imageDetail(id):
                return "id/\(id)/info"
            case let .imageUrl(id, width, height):
                return ApiBaseUrl + "id/\(id)/\(width)/\(height)"
            }
        }
    }
    
}
