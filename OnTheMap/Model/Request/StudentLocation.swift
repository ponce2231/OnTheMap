//
//  PostStudentLocation.swift
//  OnTheMap
//
//  Created by Christopher Ponce Mendez on 10/4/19.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

struct StudentLocation: Codable {
    let results:[Result]
    
 
}
struct Result: Codable {
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

//struct StudentLocation: Codable {
//    let uniqueKey: Int
//    let firstName: String
//    let lastName: String
//    let mapString: String
//    let mediaURL: String
//    let latitude: Double
//    let longitude: Double
//
//    enum CodingKeys: String, CodingKey {
//        case uniqueKey
//        case firstName
//        case lastName
//        case mapString
//        case mediaURL
//        case latitude
//        case longitude
//    }
//}
