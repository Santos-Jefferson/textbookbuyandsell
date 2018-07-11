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

class ListToBuyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate  {
    
    var image: UIImage?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    var userDet:User?
    
    var postData:[NSDictionary] = []
    var currentPostData:[NSDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.progress.startAnimating()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        userDet = Auth.auth().currentUser
        
        ref = Database.database().reference()
        
        var userID:String?
        
        databaseHandle = ref?.child("textbooks").observe(.childAdded, with: { (snapshot) in
            if let dic = snapshot.value as? [String: AnyObject]{
                userID = snapshot.key
                for (k,v) in dic{
                    self.postData.append(v as! NSDictionary)
                    self.currentPostData = self.postData
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentPostData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    var post:NSDictionary?
    var url:NSURL?
    var data:NSData?
    
    fileprivate func getDataToShow(_ indexPath: IndexPath) {
        post = currentPostData[indexPath.row]
        
        url = NSURL(string: post?.value(forKey: "imageURL") as! String)
        data = NSData(contentsOf: url! as URL)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "normalCell", for: indexPath)
    
        getDataToShow(indexPath)
        
        cell.textLabel?.text = post?.value(forKey: "Title") as? String
        cell.detailTextLabel?.text = post?.value(forKey: "Author") as? String
        cell.accessoryType = .disclosureIndicator
    
        if data != nil {
            cell.imageView?.image = UIImage(data:data! as Data)
            cell.imageView?.contentMode = .scaleAspectFit
        }
        
        self.progress.stopAnimating()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        
        getDataToShow(indexPath)
        
        vc?.image = UIImage(data:data! as Data)!
        vc?.textTitle = post?.value(forKey: "Title") as! String
        vc?.textAuthor = post?.value(forKey: "Author") as! String
//        vc?.textISBN = post?.value(forKey: "ISBN") as! String
        vc?.textCondition = post?.value(forKey: "Condition") as! String
//        vc?.textEdition = post?.value(forKey: "Edition") as! String
//        vc?.textPublisher = post?.value(forKey: "Publisher") as! String
//        vc?.textYear = post?.value(forKey: "Year") as! String
        vc?.textPrice = post?.value(forKey: "Price") as! String
        vc?.textEmail = post?.value(forKey: "Email") as! String
        
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else{
            currentPostData = postData
            self.tableView.reloadData()
            return
        }
        currentPostData = postData.filter({ textBook -> Bool in
            ((textBook.value(forKey: "Title") as? String)?.lowercased().contains(searchText.lowercased()))!
        })
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
