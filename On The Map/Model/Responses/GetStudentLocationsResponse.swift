//
//  getStudentLocationsResponse.swift
//  On The Map
//
//  Created by David Hsieh on 8/7/21.
//

import Foundation

struct GetStudentLocationsResponse: Codable {
    let results: [StudentInformation]
}
