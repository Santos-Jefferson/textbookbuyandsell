//
//  ViewController.swift
//  Textbooks Buy and Sell
//
//  Created by Jefferson Santos on 5/10/18.
//  Copyright © 2018 Jefferson Santos. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
//import FBSDKLoginKit
import FirebaseAuthUI

import FacebookCore
import FacebookLogin

class ViewController: UIViewController {
    
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil{
            print(error)
            return
        }
        print("Logged Succesfull with Facebook")
    }
    
    @objc func handleSignInWithFacebook() {
        let loginButton = LoginButton(readPermissions: [.publicProfile, .email ])
        //loginButton.center = view.center
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        //loginButton.delegate = self
        
        
        if AccessToken.current != nil {
            self.signInToFirebase()
        }
        else{
            print("NOT LOGGED $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
        }
        
        
        
//        let loginManager = LoginManager()
//        loginManager.logIn(readPermissions: [.publicProfile, .email], viewController: self){ (result) in
//            switch result {
//        case .success(grantedPermissions: _, declinedPermissions: _, token: _):
//            self.signInToFirebase()
//        case .failed(let err):
//            print(err)
//        case .cancelled:
//            print("canceled")
//            }
//        }
    }
    
    fileprivate func signInToFirebase(){
        guard let tokenAuth = AccessToken.current?.authenticationToken else {return}
        print(tokenAuth)
        print("-------------------------------------")
        let credential = FacebookAuthProvider.credential(withAccessToken: tokenAuth)
        Auth.auth().signInAndRetrieveData(with: credential) {(user, err) in
            if let err = err{
                print("ERROR: ########################## ")
                print(err)
                return
            }
            print("***************** Succesfully logged in into Facebook ********************")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        view.backgroundColor = .white
//        navigationItem.title = "Welcome"
//        handleSignInWithFacebook()
    }
    
//    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
//        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
//        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//        }
//        //print("Completed")
//    }
    
    
    
    
  
    
//    func emailEntryViewController(forAuthUI authUI: FUIAuth) -> FUIEmailEntryViewController {
//        return FUICustomEmailEntryViewController(nibName: "FUICustomEmailEntryViewController",
//                                                 bundle: Bundle.main,
//                                                 authUI: authUI)
//    }
//    
//    func passwordRecoveryViewController(forAuthUI authUI: FUIAuth, email: String) -> FUIPasswordRecoveryViewController {
//        return FUICustomPasswordRecoveryViewController(nibName: "FUICustomPasswordRecoveryViewController",
//                                                       bundle: Bundle.main,
//                                                       authUI: authUI,
//                                                       email: email)
//    }
//    
//    func passwordSignInViewController(forAuthUI authUI: FUIAuth, email: String) -> FUIPasswordSignInViewController {
//        return FUICustomPasswordSignInViewController(nibName: "FUICustomPasswordSignInViewController",
//                                                     bundle: Bundle.main,
//                                                     authUI: authUI,
//                                                     email: email)
//    }
//    
//    func passwordSignUpViewController(forAuthUI authUI: FUIAuth, email: String) -> FUIPasswordSignUpViewController {
//        return FUICustomPasswordSignUpViewController(nibName: "FUICustomPasswordSignUpViewController",
//                                                     bundle: Bundle.main,
//                                                     authUI: authUI,
//                                                     email: email)
//    }
//    
//    func passwordVerificationViewController(forAuthUI authUI: FUIAuth, email: String, newCredential: AuthCredential) -> FUIPasswordVerificationViewController {
//        return FUICustomPasswordVerificationViewController(nibName: "FUICustomPasswordVerificationViewController",
//                                                           bundle: Bundle.main,
//                                                           authUI: authUI,
//                                                           email: email,
//                                                           newCredential: newCredential)
//    }
    
  
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

