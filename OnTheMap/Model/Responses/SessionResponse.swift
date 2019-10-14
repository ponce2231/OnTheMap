//
//  SessionResponse.swift
//  OnTheMap
//
//  Created by Christopher Ponce Mendez on 10/8/19.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

struct SessionResponse: Codable{
    let account: Account
    let session: Session
    enum CodingKeys: String, CodingKey {
        case account
        case session
    }
}

struct Account: Codable {
    let registered:Bool
    let key: Int
}

struct Session:Codable {
    let id: String
    let expiration: String

}
