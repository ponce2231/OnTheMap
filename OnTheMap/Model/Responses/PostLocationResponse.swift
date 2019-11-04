//
//  PostLocationResponse.swift
//  OnTheMap
//
//  Created by Christopher Ponce Mendez on 10/9/19.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation
struct PostLocationResponse: Codable {
    let createdAt: String
    var objectID: String
    static var postLocationInstance: PostLocationResponse?
    enum CodingKeys: String,CodingKey {
        case createdAt
        case objectID = "objectId"
    }
}
