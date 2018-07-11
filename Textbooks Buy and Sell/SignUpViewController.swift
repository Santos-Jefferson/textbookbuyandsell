//
//  SignUpViewController.swift
//  Textbooks Buy and Sell
//
//  Created by Jefferson Santos on 5/22/18.
//  Copyright © 2018 Jefferson Santos. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
//import FirebaseAuthUI

class SignUpViewController: UIViewController, UITextFieldDelegate{
    
    //Text Fields to signup
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.delegate = self
        password.delegate = self
        confirmPassword.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        email.resignFirstResponder()
        password.resignFirstResponder()
        confirmPassword.resignFirstResponder()
        return true
    }

    //Singup on Firebase
    @IBAction func FirebaseSignup(_ sender: Any) {
        let email = self.email.text
        let password = self.password.text
        let confirm = confirmPassword.text
        if password == confirm {
            self.progress.startAnimating()
            Auth.auth().createUser(withEmail: email!, password: password!) { (authResult, error) in
            if let error = error{
                self.progress.stopAnimating()
                self.showAlert(error)
                return
            }else{
                self.showConfirm()
                }
            }
            
        } else {
            progress.stopAnimating()
            self.showPasswordError()
        }
    }
      

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Show alert error
    fileprivate func showAlert(_ error: Error) {
        //Alert if some error happens
        let alert = UIAlertController(title: "Signup Error?", message: error.localizedDescription, preferredStyle: .alert)
        //user action Yes, No
        alert.addAction(UIAlertAction(title: "Try Again!", style: .default, handler: nil))
        //Present the alert
        self.present(alert, animated: true)
    }
    
    //Show signup confirmation
    fileprivate func showConfirm() {
        //Alert if signup was confirmed
        let alert = UIAlertController(title: "Signup Confirmation!", message: "Congrats, your account has been created!", preferredStyle: .alert)
        //user action OK
        alert.addAction(UIAlertAction(title: "Use the App", style: .default, handler: {(action) in
            self.performSegue(withIdentifier: "navbarsignup", sender: self)
        }))
        //Present the alert
        self.present(alert, animated: true)
    }
    
    //Show signup confirmation
    fileprivate func showPasswordError() {
        //Alert if signup was confirmed
        let alert = UIAlertController(title: "Passwords are not equals!", message: "Type again!", preferredStyle: .alert)
        //user action OK
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        //Present the alert
        self.present(alert, animated: true)
    }
    

}
