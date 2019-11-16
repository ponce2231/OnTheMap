//
//  SessionResponse.swift
//  OnTheMap
//
//  Created by Christopher Ponce Mendez on 10/8/19.
//  Copyright © 2019 none. All rights reserved.
//
import Foundation

// MARK: SessionResponse

struct SessionResponse: Codable {
    static var sessionInstance: SessionResponse?
    let account: Account
    var session: Session
}


struct Account: Codable {
    let registered: Bool
    var key: String
}


struct Session: Codable {
    var id: String
    let expiration: String
}


