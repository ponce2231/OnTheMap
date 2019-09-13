//
//  StudentLocationRequest.swift
//  OnTheMap
//
//  Created by Christopher Ponce Mendez on 9/12/19.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

struct StudentLocationRequest: Codable {
    let objectId: String
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case objectId
        case uniqueKey
        case firstName
        case lastName
        case mapString
        case mediaURL
        case latitude = "latitude"
        case longitude = "longitude"
    }
}
