//
//  UdacityError.swift
//  On The Map
//
//  Created by David Hsieh on 8/7/21.
//

import Foundation

struct OTMError: Codable {
    let status: Int
    let error: String
}

extension OTMError: LocalizedError {
    var errorDescription: String? {
        return error
    }
}
