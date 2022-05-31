//
//  SessionResponse.swift
//  On The Map
//
//  Created by David Hsieh on 8/5/21.
//

import Foundation

struct SessionResponse: Codable {
    let session: Session
}

struct Session: Codable {
    let id: String
}
