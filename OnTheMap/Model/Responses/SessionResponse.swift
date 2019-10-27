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
    let session: Session
}

// MARK: Account
struct Account: Codable {
    let registered: Bool
    let key: String
}

// MARK: Session
struct Session: Codable {
    let id, expiration: String
}


