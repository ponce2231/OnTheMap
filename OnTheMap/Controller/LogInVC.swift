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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    

    @IBAction func loginTapped(_ sender: Any) {
        setLoggingIn(true)
        UdacityClient.postLoginSession(userName: emailTextField.text ?? "", password: passwordTextField.text ?? "",completionHandler: handleLogin(success:error:))
    }
    @IBAction func signUpTapped(_ sender: Any) {
        let url = "https://auth.udacity.com/sign-up?next=https://classroom.udacity.com/authenticated"
        let signUp = UIApplication.shared
        signUp.open(URL(string: url)!)
        
    }
    
    func handleLogin(success:Bool, error:Error?){
        setLoggingIn(false)
        if success{
            performSegue(withIdentifier: "completeLogin", sender: nil)
            
        }else{
        
            self.showLoginFailure(message: error?.localizedDescription ?? "" )
                
        }
    }
    //MARK: Shows alert when credentials are not correct
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
    func setLoggingIn(_ loggingIn: Bool) {
        if loggingIn {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        emailTextField.isEnabled = !loggingIn
        passwordTextField.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
    }
    
}

