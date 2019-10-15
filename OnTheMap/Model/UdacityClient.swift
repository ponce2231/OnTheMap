//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Christopher Ponce Mendez on 9/28/19.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation
class UdacityClient {
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        
        case login
        
        var urlString:String {
            switch self {
            case .login: return Endpoints.base + "/session"
            }

        }
        var url: URL {
            return URL(string: urlString)!
        }
    }
    //https://www.youtube.com/watch?v=YY3bTxgxWss
    class func postLoginSession(userName:String,password:String, completionHandler: @escaping (Bool,Error?) -> Void){
        
        var request = URLRequest(url: Endpoints.login.url)
        let credentials = ["udacity":["username":userName, "password":password]] as [String:AnyObject]
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // encoding a JSON body from a string, can also use a Codable struct
        do{
            let body = try JSONSerialization.data(withJSONObject: credentials, options: .prettyPrinted)
            request.httpBody = body
            completionHandler(true,nil)
        }catch{
            completionHandler(false,error)
        }
        print(credentials["udacity"])
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else{
                return
            }
            //Range(5..<data!.count)
            let range = (5..<data.count)
            let newData = data.subdata(in: range) /* subset response data! */
            do{

                let dataObject = try JSONSerialization.jsonObject(with: newData, options: .allowFragments) as? [String:AnyObject]
                if let session = dataObject?["session"] as? [String:AnyObject]{
                    print(session)
                    if let sessionID = dataObject?["id"] as? String{
                        print(sessionID)
                        print(String(data: newData, encoding: .utf8)!)
                    }
                }else{
                    print(dataObject?["error"])
                    completionHandler(false, error)
                    return
                }
                    
            }catch{
                completionHandler(false, error)
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    class func deleteSession(){
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "DELETE"
        
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            
          if cookie.name == "XSRF-TOKEN"{
                xsrfCookie = cookie
            
            }
        }
        
        if let xsrfCookie = xsrfCookie {
          request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
          if error != nil { // Handle error…
              return
          }
            //Range(5..<data!.count)
          let range = (5..<data!.count)
          let newData = data?.subdata(in: range) /* subset response data! */
          print(String(data: newData!, encoding: .utf8)!)
        }
        task.resume()
    }
    
    class func getPublicUserData(){
                                                                                            //<userId = 3903878747>
        let request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/users/3903878747")!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
          if error != nil { // Handle error...
              return
          }
            //Range(5..<data!.count)
          let range = (5..<data!.count)
          let newData = data?.subdata(in: range) /* subset response data! */
          print(String(data: newData!, encoding: .utf8)!)
        }
        task.resume()
    }
    
}
