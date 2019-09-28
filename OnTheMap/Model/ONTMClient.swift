//
//  ONTMClient.swift
//  OnTheMap
//
//  Created by Christopher Ponce Mendez on 9/11/19.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

class ONTMClient {
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1/StudentLocation"
        
        case getStudentsLocation
        
        
        var urlString:String {
            switch self {
            case .getStudentsLocation: return Endpoints.base + "?limit=5"

            }

        }
        var url: URL {
            return URL(string: urlString)!
        }
    }
    
    class func getStudentsLocations(){
        
        
        let dataTask = URLSession.shared.dataTask(with: Endpoints.getStudentsLocation.url) { data, response, error in

            if error != nil {
                return
            }
//            let decoder = JSONDecoder()
//            do{
//                let responseObject = try decoder.decode(StudentLocationRequest.self, from: data)
//                completionHandler(true,nil)
//            }catch{
//                completionHandler(false,error)
//            }
            print(String(data: data!, encoding: .utf8)!)
        }
        dataTask.resume()
        
    }
    
    class func postStudentLocation(){
        var request = URLRequest(url: URL(string: Endpoints.base)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"Chris\", \"lastName\": \"Ponce\",\"mapString\": \"San Juan, PR\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 18.465841, \"longitude\": -66.105871}".data(using: .utf8)
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                return
            }
            print(String(data: data!, encoding: .utf8)!)
        }
        dataTask.resume()
    }
}
