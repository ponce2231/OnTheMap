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
    /*
     pasar la localizacion y el url de esta pantalla a submitLocationVC
     en submit location vc llamar la funcion de postStudentlocation
     verificar que el url se pueda abrir en safari 
    */
    @IBAction func findLocationButtonPressed(_ sender: Any) {
        let submitLocationVC = self.storyboard?.instantiateViewController(withIdentifier: "SubmitLocationVC") as! SubmitLocationVC
        submitLocationVC.locationString = enterLocationTextField.text
        submitLocationVC.siteString = enterSiteTextField.text
        performSegue(withIdentifier: "passDataSegue", sender: nil)

        
      
        
    }
    
}
