//
//  SellPhotoViewController.swift
//  Textbooks Buy and Sell
//
//  Created by Jefferson Santos on 5/22/18.
//  Copyright © 2018 Jefferson Santos. All rights reserved.
//

import UIKit
import Firebase
import CoreData
import FirebaseDatabase
import FirebaseStorage

class SellPhotoViewController: UIViewController, UITextFieldDelegate{
    
    //progress circle
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    //Empty Firebase database reference
    var ref:DatabaseReference?
    
    //Current user details
    var userEmail:String?
    let userDetails = Auth.auth().currentUser
    
    //Place where image from previous controller will appear
    @IBOutlet weak var photo: UIImageView!
    
    //empty image variable
    var image: UIImage!
    
    //form fields - textbook data
    @IBOutlet weak var textbookTitle: UITextField!
    @IBOutlet weak var textbookAuthor: UITextField!
    @IBOutlet weak var textbookCondition: UITextField!
    @IBOutlet weak var textbookPrice: UITextField!
    //    @IBOutlet weak var textbookPublisher: UITextField!
    //    @IBOutlet weak var textbookISBN: UITextField!
    //    @IBOutlet weak var textbookEdition: UITextField!
    //    @IBOutlet weak var textbookYear: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self delegate for fields
        textbookTitle.delegate = self
        textbookAuthor.delegate = self
        textbookCondition.delegate = self
        textbookPrice.delegate = self
        //        textbookPublisher.delegate = self
        //        textbookISBN.delegate = self
        //        textbookEdition.delegate = self
        //        textbookYear.delegate = self
        
        //Firebase reference
        ref = Database.database().reference()
        
        userEmail = userDetails?.email
        
        photo.image = self.image
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textbookTitle.resignFirstResponder()
        textbookAuthor.resignFirstResponder()
        textbookCondition.resignFirstResponder()
        textbookPrice.resignFirstResponder()
        //        textbookPublisher.resignFirstResponder()
        //        textbookISBN.resignFirstResponder()
        //        textbookEdition.resignFirstResponder()
        //        textbookYear.resignFirstResponder()
        return true
    }
    
    //close ios keyboard when tap anywhere
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Retake photo / cancel photo
    @IBAction func CancelPhoto(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //Save photo and forms to firebase
    @IBAction func SavePhoto(_ sender: Any) {
        
        if ((self.textbookPrice.text?.isEmpty)! ||
            (self.textbookTitle.text?.isEmpty)! ||
            (self.textbookAuthor.text?.isEmpty)! ||
            (self.textbookCondition.text?.isEmpty)!){
            let error = "Empty fields are not permitted"
            showAlert(error: error)
        } else{
            //progress circle starts here
            progress.startAnimating()
            
            //Get a reference to the storage service
            let storage = Storage.storage()
            
            //Create a storage reference from our storage service
            let storageRef = storage.reference()
            
            var data = Data()
            data = UIImageJPEGRepresentation(photo.image!, 0.1)!
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"
            
            let userRef = ref?.child("textbooks").child((userDetails?.uid)!)
            let textRef = userRef?.childByAutoId()
            
            let fullPath = "textbooks/images/\(userDetails?.uid)/\(textRef?.key)/cover.jpg"
            
            let textbookRef = storageRef.child(fullPath)
            
            //let imageURL: String!
            
            //imageURL = "\(textbookRef.bucket)/\(textbookRef.fullPath)"
            
            let textTitle = textRef?.child("Title")
            textTitle?.setValue(textbookTitle.text)
            
            let textAuthor = textRef?.child("Author")
            textAuthor?.setValue(textbookAuthor.text)
            
            let textCondition = textRef?.child("Condition")
            textCondition?.setValue(textbookCondition.text)
            
            //        let textISBN = textRef?.child("ISBN")
            //        textISBN?.setValue(textbookISBN.text)
            //
            let textPrice = textRef?.child("Price")
            textPrice?.setValue(textbookPrice.text)
            //
            //        let textEdition = textRef?.child("Edition")
            //        textEdition?.setValue(textbookEdition.text)
            //
            //        let textPublisher = textRef?.child("Publisher")
            //        textPublisher?.setValue(textbookPublisher.text)
            //
            //        let textYear = textRef?.child("Year")
            //        textYear?.setValue(textbookYear.text)
            
            let textEmail = textRef?.child("Email")
            textEmail?.setValue(userEmail)
            
            let uploadTask = textbookRef.putData(data, metadata: metaData, completion: { (metaData, error) in
                textbookRef.downloadURL(completion: { (url, error) in
                    if let imgurl = url?.absoluteString {
                        let textURL = textRef?.child("imageURL")
                        textURL?.setValue(imgurl)
                        
                        self.progress.stopAnimating()
                        self.showAlertSuccess(error: "Thanks for using our App")
                    }
                }
            )}
        )}
        return
    }
    
    //Show alert error
    fileprivate func showAlert(error:String) {
        //Alert if some error happens
        let alert = UIAlertController(title: "Error saving the Textbook!", message: error, preferredStyle: .alert)
        //user action Yes, No
        alert.addAction(UIAlertAction(title: "I'll fill out the fields!", style: .default, handler: nil))
        //Present the alert
        self.present(alert, animated: true)
    }
    
    //Show alert error
    fileprivate func showAlertSuccess(error:String) {
        //Alert if some error happens
        let alert = UIAlertController(title: "Textbook saved with success!", message: error, preferredStyle: .alert)
        //user action Yes, No
        alert.addAction(UIAlertAction(title: "Click in \"BUY Textbooks\" to view your ad!", style: .default, handler: {(action) in
            self.performSegue(withIdentifier: "navbar", sender: self)
        }))
        //Present the alert
        self.present(alert, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
