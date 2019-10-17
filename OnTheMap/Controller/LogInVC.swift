//
//  ViewController.swift
//  OnTheMap
//
//  Created by Christopher Ponce Mendez on 9/11/19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class LogInVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginTapped(_ sender: Any) {
        UdacityClient.postLoginSession(userName: emailTextField.text ?? "", password: passwordTextField.text ?? "",completionHandler: handleLogin(success:error:))
    }
    
    func handleLogin(success:Bool, error:Error?){
        if success{
            performSegue(withIdentifier: "completeLogin", sender: nil)
        }else{
            DispatchQueue.main.async {
                self.showLoginFailure(message: error?.localizedDescription ?? "" )
            }
           
        }
    }
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
}

