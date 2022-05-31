//
//  AccountInfo.swift
//  On The Map
//
//  Created by David Hsieh on 8/9/21.
//

import Foundation

struct UserData: Codable {
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
