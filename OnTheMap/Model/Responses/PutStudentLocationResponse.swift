//
//  PutStudentLocationResponse.swift
//  OnTheMap
//
//  Created by Christopher Ponce Mendez on 10/9/19.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

struct PutStudentLocationResponse:Codable {
    let updatedAt: String
    
    enum CodingKeys:String, CodingKey {
        case updatedAt = "updatedAt"
    }
}
