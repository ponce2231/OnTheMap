//
//  ViewController.swift
//  OnTheMap
//
//  Created by Christopher Ponce Mendez on 9/11/19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ONTMClient.getAllStudentsLocations(completionHandler:getAllStudentsHandler(succes:error:))
    }
    
    func getAllStudentsHandler(succes: Bool, error: Error?){
        if succes{
            print("success")
        }else{
            print(error!)
        }
    }

}

