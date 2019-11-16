//
//  ViewControlerAndTextFieldDelegate.swift
//  OnTheMap
//
//  Created by Christopher Ponce Mendez on 11/16/19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit
extension UIViewController: UITextFieldDelegate{
    //MARK:-dismisses the keyboard
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
