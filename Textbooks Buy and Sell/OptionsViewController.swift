//
//  OptionsViewController.swift
//  Textbooks Buy and Sell
//
//  Created by Jefferson Santos on 5/28/18.
//  Copyright © 2018 Jefferson Santos. All rights reserved.
//

import UIKit
import Firebase

class OptionsViewController: UIViewController {

    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var sellButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.buyButton.layer.cornerRadius = 10
        self.sellButton.layer.cornerRadius = 10
        self.logoutButton.layer.cornerRadius = 10
        self.buyButton.clipsToBounds = true
        self.sellButton.clipsToBounds = true
        self.logoutButton.clipsToBounds = true
        
        if Auth.auth().currentUser == nil {
            self.performSegue(withIdentifier: "logout", sender: self)
        }
        
        print(Auth.auth().currentUser?.email)
    }
    @IBAction func logout(_ sender: Any) {
        try! Auth.auth().signOut()
        self.performSegue(withIdentifier: "init", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
    }
}
