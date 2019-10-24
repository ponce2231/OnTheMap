//
//  SessionResponse.swift
//  OnTheMap
//
//  Created by Christopher Ponce Mendez on 10/8/19.
//  Copyright © 2019 none. All rights reserved.
//
import Foundation

// MARK: - SessionResponse
struct SessionResponse: Codable {
    let account: Account
    let session: Session
}

// MARK: - Account
struct Account: Codable {
    let registered: Bool
    let key: String
}

// MARK: - Session
struct Session: Codable {
    let id, expiration: String
}


//struct SessionResponse: Codable{
//    let account: Account
//    let session: Session
//
//    enum CodingKeys: String, CodingKey {
//        case account
//        case session
//    }
//}
//
//struct Account: Codable {
//    let registered:Bool
//    let key: Int
//}
//
//struct Session:Codable {
//    let id: String
//    let expiration: String
//
//}

//extension SessionResponse{
//    struct CodingData:Codable {
//        struct Container: Codable {
//            let account:String
//            let session:String
//        }
//        var accountData: Container
//    }
//}
