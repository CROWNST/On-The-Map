//
//  LoginRequest.swift
//  On The Map
//
//  Created by David Hsieh on 8/11/21.
//

import Foundation

struct LoginRequest: Codable {
    let udacity: Credentials
}

struct Credentials: Codable {
    let username: String
    let password: String
}
