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
        do{
            let body = try JSONSerialization.data(withJSONObject: credentials, options: .prettyPrinted)
            request.httpBody = body
        }catch{
            completionHandler(false,error)
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil{
                print(error?.localizedDescription)
                print("bananas")
                return
            }
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
                    DispatchQueue.main.async {
                        
                        completionHandler(false, error)
                        print(error?.localizedDescription)
                        print("hamburguer")
                    }
                }
            }catch{
                DispatchQueue.main.async {
                      completionHandler(false, error)
                      print(error.localizedDescription)
                    print("yogurt")
                }
              
            }
        }
        task.resume()
    }
    
    class func deleteSession(completionHandler: @escaping (Bool,Error?) -> Void){
        var request = URLRequest(url: Endpoints.login.url)
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
            guard let data = data else{
                return
            }
            //Range(5..<data!.count)
          let range = (5..<data.count)
          let newData = data.subdata(in: range) /* subset response data! */
            do{
                let decoder = JSONDecoder()
                var responseObject = try decoder.decode(SessionResponse.self, from: newData)
                responseObject.session.id = ""
                completionHandler(true,nil)
            }catch{
                completionHandler(false, error)
            }
          print(String(data: newData, encoding: .utf8)!)
        }
        task.resume()
    }
    
    
}
