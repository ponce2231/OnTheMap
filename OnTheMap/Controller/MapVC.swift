//
//  MapVC.swift
//  OnTheMap
//
//  Created by Christopher Ponce Mendez on 9/28/19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class MapVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ONTMClient.getStudentsLocations(completionHandler: getLocationHandler(success:error:))
    }
    func getLocationHandler(success:Bool, error: Error?) {
        if success{
            print("got locations")
        }else{
            print(error?.localizedDescription)
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
