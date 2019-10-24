//
//  PostStudentLocation.swift
//  OnTheMap
//
//  Created by Christopher Ponce Mendez on 10/4/19.
//  Copyright © 2019 none. All rights reserved.
//

//import Foundation
//// https://stackoverflow.com/questions/46597624/can-swift-convert-a-class-struct-data-into-dictionary
//
struct StudentLocation: Codable {
    let uniqueKey: Int
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case uniqueKey
        case firstName
        case lastName
        case mapString
        case mediaURL
        case latitude
        case longitude
    }
}
