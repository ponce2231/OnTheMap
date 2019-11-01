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
        case puttingStudentLocation(String)
        
        var urlString:String {
            switch self {
            case .getStudentsLocation: return Endpoints.base + "?limit=5"
            case .puttingStudentLocation(let objectId): return Endpoints.base + "/\(objectId)"
            }

        }
        var url: URL {
            return URL(string: urlString)!
        }
    }
    //MARK: Gets student location
    class func getStudentsLocations(completionHandler: @escaping (Bool, Error?) -> Void){
        
        
        let dataTask = URLSession.shared.dataTask(with: Endpoints.getStudentsLocation.url) { data, response, error in
           
            guard let data = data else{
                completionHandler(false, error)
                return
            }
            if error != nil {
               return
           }
            do{
                let responseObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:AnyObject]
                if let results = responseObject?["results"] as? [[String:AnyObject]]{
                    
                    if results.count > 0{
                        for item in results{
                            print(item["firstName"])
                        }
                        completionHandler(true,nil)
                    }
                }else{
                    completionHandler(false,error)
                    print(error)
                    return
                }
            }catch{
                completionHandler(false,error)
                print(error)
            }
        }
        dataTask.resume()
        
    }
     //MARK: post a student location on map
    class func postStudentLocation(firstName: String, lastName:String, country: String, linkedInString: String, xAxis: Double, yAxis:Double, completionHandler: @escaping (Bool, Error?) -> Void){

        
        var request = URLRequest(url: URL(string: Endpoints.base)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // need to convert this to dictionary
        let userInput = ["uniqueKey": SessionResponse.sessionInstance?.account.key,"firstName":firstName, "lastName": lastName, "mapString": country, "mediaURL": linkedInString,"latitude": xAxis, "longitude": yAxis] as [String:AnyObject]
        do{
            let body = try JSONSerialization.data(withJSONObject: userInput, options: .prettyPrinted)
            request.httpBody = body
            completionHandler(true, nil)
        }catch{
            completionHandler(false, error)
        }
        
        //MARK: creating a datatask
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else{
                completionHandler(false,error)
                return
            }
            if error != nil {
                return
            }
          //MARK: parsing json response
            do{
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode(PostLocationResponse.self, from: data)
                print(responseObject)
                completionHandler(true,nil)
            }catch{
                completionHandler(false,error)
            }
            
            
            print(String(data: data, encoding: .utf8)!)
        }
        dataTask.resume()
    }
    
    class func putStudentLocation(firstName: String, lastName:String, country: String, linkedInString: String, xAxis: Double, yAxis:Double, completionHandler: @escaping (Bool, Error?) -> Void){
        var request = URLRequest(url: Endpoints.puttingStudentLocation("bm7shks74d6btkc0vslg").url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let userInput = ["firstName":firstName, "lastName": lastName, "mapString": country, "mediaURL": linkedInString,"latitude": xAxis, "longitude": yAxis] as [String:AnyObject]
//        request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"Chris\", \"lastName\": \"Ponce\",\"mapString\": \"San Juan, PR\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 18.465841, \"longitude\": -66.105871}".data(using: .utf8)
        
        do{
            let body = try JSONSerialization.data(withJSONObject: userInput, options: .prettyPrinted)
            request.httpBody = body
            completionHandler(true,nil)
            print(body)
        }catch{
            completionHandler(false,error)
        }
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error != nil{
                return
            }
           print(String(data: data!, encoding: .utf8)!)
        }
        dataTask.resume()
    }
}
