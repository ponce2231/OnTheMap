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
        ONTMClient.postStudentLocation()

        ONTMClient.getStudentsLocations()
    }
    
    func getStudentsHandler(success: Bool, error: Error?){
        if success{
            print("success")
        }else{
            print(error!)
        }
    }
    func postStudentLocationHandler(success: Bool, error: Error?){
        if success{
            print("success 2")
        }else{
            print(error!)
        }
    }

}

