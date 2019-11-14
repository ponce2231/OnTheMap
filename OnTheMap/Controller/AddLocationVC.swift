//
//  AddLocationVC.swift
//  OnTheMap
//
//  Created by Christopher Ponce Mendez on 9/28/19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class AddLocationVC: UIViewController {
    @IBOutlet weak var enterLocationTextField: UITextField!
    @IBOutlet weak var enterSiteTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
 
    @IBAction func findLocationButtonPressed(_ sender: Any) {

        performSegue(withIdentifier: "passDataSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let submitLocationVC = segue.destination as! SubmitLocationVC
        submitLocationVC.locationString = enterLocationTextField.text
        submitLocationVC.siteString = enterSiteTextField.text
    }
    
}
