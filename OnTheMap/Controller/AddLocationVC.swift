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
        if enterLocationTextField.text == "" || enterSiteTextField.text == ""{
            emptyTextAlert(message: "The location or the site text fields are empty")
        }else{
            performSegue(withIdentifier: "passDataSegue", sender: nil)
        }
        
    }
    func emptyTextAlert(message: String) {
        let textAletVC = UIAlertController(title: "Error Message", message: message, preferredStyle: .alert)
        textAletVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(textAletVC, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let submitLocationVC = segue.destination as! SubmitLocationVC
        submitLocationVC.locationString = enterLocationTextField.text
        submitLocationVC.siteString = enterSiteTextField.text
    }
    
    @IBAction func cancelWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
