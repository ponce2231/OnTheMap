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
   
    class func postLoginSession(userName:String,password:String, completionHandler: @escaping (Bool,Error?) -> Void){
        //var declarations
        var request = URLRequest(url: Endpoints.login.url)
        let credentials = ["udacity":["username":userName, "password":password]] as [String:AnyObject]
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       //needs more work
        // convert body into a dictionary
        do{
            let body = try JSONSerialization.data(withJSONObject: credentials, options: .prettyPrinted)
            request.httpBody = body
        }catch{
            completionHandler(false,error)
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else{
                
                return
            }
            let range = (5..<data.count)
            let newData = data.subdata(in: range) /* subset response data! */
            do{
                //MARK: parsing json
                let decoder = JSONDecoder()
                let sessionResponse = try decoder.decode(SessionResponse.self, from: newData)
                
                SessionResponse.sessionInstance = sessionResponse
                //MARK: Account Validation
                if sessionResponse.account.registered{
                    DispatchQueue.main.async {
                        completionHandler(true,nil)
                    }
                }else{
                    completionHandler(false,error)
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
    
    class func getPublicUserData(completionHandler: @escaping (Bool, Error?) -> Void){
                                                                                            //<userId = 3903878747>
        let request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/users/3903878747")!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
          if error != nil { // Handle error...
              return
          }
            guard let data = data else{
                completionHandler(false, error)
                return
                
            }
            //Range(5..<data!.count)
          let range = (5..<data.count)
          let newData = data.subdata(in: range) /* subset response data! */
            
          print(String(data: newData, encoding: .utf8)!)
        }
        task.resume()
    }
    
}
