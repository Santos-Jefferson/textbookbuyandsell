//
//  ListToBuyViewController.swift
//  Textbooks Buy and Sell
//
//  Created by Jefferson Santos on 5/26/18.
//  Copyright © 2018 Jefferson Santos. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ListToBuyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cellview: UIView!
    
    var ref:DatabaseReference!
    var databaseHandle:DatabaseHandle?

    var postData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        //set the firebase reference
        ref = Database.database().reference()
        let userDet = Auth.auth().currentUser
        
        ref?.child("textbooks").child((userDet?.uid)!).observe(.childAdded, with: { (snapshot) in
            
            //take the value from snapshop and add it to the postData array
            let post = snapshot.value as? String
            
            if let actualPost = post {
                self.postData.append(actualPost)
                
                self.tableView.reloadData()
            }
        })
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "ListToBuyViewController")
        let cell = UITableViewCell()
        cell.textLabel?.text = postData[indexPath.row]
        return cell
    }
}
