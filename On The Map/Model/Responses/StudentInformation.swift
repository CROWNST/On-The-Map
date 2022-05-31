//
//  StudentInformation.swift
//  On The Map
//
//  Created by David Hsieh on 8/5/21.
//

import Foundation

struct StudentInformation: Codable {
    var uniqueKey: String
    var firstName: String
    var lastName: String
    var mapString: String
    var mediaURL: String
    var latitude: Double
    var longitude: Double
}
