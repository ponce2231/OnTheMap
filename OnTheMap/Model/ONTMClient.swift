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
            case .getStudentsLocation: return Endpoints.base + "?order=-updatedAt"

            }

        }
        var url: URL {
            return URL(string: urlString)!
        }
    }
    
    class func getAllStudentsLocations(completionHandler:@escaping (Bool,Error?) -> Void){
        
        
        let dataTask = URLSession.shared.dataTask(with: Endpoints.getStudentsLocation.url) { data, response, error in
            guard let data = data else{
                completionHandler(false,error)
                return
            }
            let decoder = JSONDecoder()
            do{
                let responseObject = try decoder.decode(StudentLocationRequest.self, from: data)
                completionHandler(true,nil)
            }catch{
                completionHandler(false,error)
            }
            print(String(data: data, encoding: .utf8))
        }
        dataTask.resume()
        
    }
    
    
}
