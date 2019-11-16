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
            case .getStudentsLocation: return Endpoints.base + "?limit=100" + "&order=-updatedAt"
            case .puttingStudentLocation(let objectId): return Endpoints.base + "/\(objectId)"
            }

        }
        var url: URL {
            return URL(string: urlString)!
        }
    }
    
    //MARK: Gets student location
    class func getStudentsLocations(completionHandler: @escaping ([Result], Error?) -> Void){
        let dataTask = URLSession.shared.dataTask(with: Endpoints.getStudentsLocation.url) { data, response, error in
           
            guard let data = data else{
                completionHandler([], error)
                return
            }
            if error != nil {
               return
           }
            do{
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode(StudentLocation.self, from: data)
                dump(responseObject)
                LocationsData.locations = responseObject.results
                DispatchQueue.main.async {
                    completionHandler(LocationsData.locations,nil)
                }
               
                
            }catch{
                DispatchQueue.main.async {
                    completionHandler([],error)
                }
                
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
                PostLocationResponse.postLocationInstance?.objectID = responseObject.objectID
                DispatchQueue.main.async {
                    completionHandler(true,nil)
                }
                
            }catch{
                DispatchQueue.main.async {
                    completionHandler(false,error)
                }
                
            }
            print(String(data: data, encoding: .utf8)!)
        }
        dataTask.resume()
    }
}
