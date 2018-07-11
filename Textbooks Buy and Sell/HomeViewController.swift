//
//  HomeViewController.swift
//  Textbooks Buy and Sell
//
//  Created by Jefferson Santos on 5/23/18.
//  Copyright © 2018 Jefferson Santos. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITextFieldDelegate {
    
    //Handle the user signed in
    var handle: AuthStateDidChangeListenerHandle?
    
    //Text Fields for login
    @IBOutlet weak var emailInputHome: UITextField!
    @IBOutlet weak var passwordInputHome: UITextField!
    
    //Labels for login
    @IBOutlet weak var loggedAsTextField: UILabel!
    
    //ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "segue", sender: self)
        }
        emailInputHome.delegate = self
        passwordInputHome.delegate = self
        
    }

    //Close keyboard when tap and other area
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //status progress animated
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    //Login Button
    @IBAction func FirebaseLogin(_ sender: UIButton) {
        self.progress.startAnimating()
        let auth = Auth.auth()
        let email = self.emailInputHome.text
        let password = self.passwordInputHome.text
        auth.signIn(withEmail: email!, password: password!) { (user, error) in
            if let error = error {
                self.showAlert(error)
                //Console print
                print(error)
                self.progress.stopAnimating()
            return
            }
             self.performSegue(withIdentifier: "segue", sender: self)
            }
        }
    
    //Function to put the keyboard down when pressed RETURN
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailInputHome.resignFirstResponder()
        passwordInputHome.resignFirstResponder()
        return true
    }
    
    //showAlert
    fileprivate func showAlert(_ error: Error) {
        //Alert if some error happens
        let alert = UIAlertController(title: "Login Error?", message: error.localizedDescription, preferredStyle: .alert)
        //user action Yes, No
        alert.addAction(UIAlertAction(title: "Try Again!", style: .default, handler: nil))
        //Present the alert
        self.present(alert, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTitleDisplay(_ user: User?) {
        if let name = user?.displayName {
            self.navigationItem.title = "Welcome \(user?.email)"
        } else {
            self.navigationItem.title = "Login"
        }
    }
    
    //To handle user in others views
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            self.setTitleDisplay(user)
        }
        self.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
    //To remove the handle user in others views
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
}
