//
//  PostStudentLocation.swift
//  OnTheMap
//
//  Created by Christopher Ponce Mendez on 10/4/19.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

// MARK: - StudentLocation
struct StudentLocation: Codable {
    var results: [Result]
    static var dataLocations:StudentLocation?
}

// MARK: - Result
struct Result: Codable {
    let createdAt, firstName, lastName: String
    let latitude, longitude: Double
    let mapString: String
    let mediaURL: String
    let objectID, uniqueKey, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case createdAt, firstName, lastName, latitude, longitude, mapString, mediaURL
        case objectID = "objectId"
        case uniqueKey, updatedAt
    }
}
