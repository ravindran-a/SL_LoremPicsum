//
//  String+Helper.swift
//  LoremPicsum
//
//  Created by Ravindran on 05/03/23.
//

import Foundation

extension String {
    var urlEncoded: String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
