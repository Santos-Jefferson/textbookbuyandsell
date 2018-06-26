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
   
    var ref:DatabaseReference?
    
    @IBOutlet weak var photo: UIImageView!
    var image: UIImage!
   
    //form fields - textbook data
    @IBOutlet weak var textbookTitle: UITextField!
    @IBOutlet weak var textbookAuthor: UITextField!
    @IBOutlet weak var textbookCondition: UITextField!
    @IBOutlet weak var textbookPrice: UITextField!
    @IBOutlet weak var textbookPublisher: UITextField!
    @IBOutlet weak var textbookISBN: UITextField!
    @IBOutlet weak var textbookEdition: UITextField!
    @IBOutlet weak var textbookYear: UITextField!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //self delegate for fields
        textbookTitle.delegate = self
        textbookAuthor.delegate = self
        textbookCondition.delegate = self
        textbookPrice.delegate = self
        textbookPublisher.delegate = self
        textbookISBN.delegate = self
        textbookEdition.delegate = self
        textbookYear.delegate = self
        
        ref = Database.database().reference()
        
        photo.image = self.image
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textbookTitle.resignFirstResponder()
        textbookAuthor.resignFirstResponder()
        textbookCondition.resignFirstResponder()
        textbookPrice.resignFirstResponder()
        textbookPublisher.resignFirstResponder()
        textbookISBN.resignFirstResponder()
        textbookEdition.resignFirstResponder()
        textbookYear.resignFirstResponder()
        return true
    }
    
    //close ios keyboard when tap anywhere
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func CancelPhoto(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func SavePhoto(_ sender: Any) {
        
        //Get a reference to the storage service
        let storage = Storage.storage()
        
        //Create a storage reference from our storage service
        let storageRef = storage.reference()
        
        var data = Data()
        data = UIImageJPEGRepresentation(photo.image!, 0.5)!
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        let textbookRef = storageRef.child("images/textbookCover.jpg")
        
        let imageURL: String!
        imageURL = "\(textbookRef.bucket)/\(textbookRef.fullPath)"
    
        
        let uploadTask = textbookRef.putData(data, metadata: metaData) { (metaData, error) in
            guard let metadata = metaData else {
                //error occurred
                return
            }
            let size = metadata.size
            storageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    //error occurred
                    return
                }
            }
        }
        
        
        //imagesref now points to "images"
        //let imagesRef = storageRef.child("images")
        
        //spaceRef points to images/space.jpg
        //imagesRef still points to images
        //var spaceRef = storageRef.child("images/space.jpg")
        
        //Creating the full referece
        //let storagePath = "\textbooks/images/space.jpg"
        //spaceRef = storage.reference(forURL: storagePath)
        
        
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//        dismiss(animated: true, completion: nil)
        
        
        
        //ref?.child("Textbooks").child((firebaseAuth.currentUser?.email)!).childByAutoId().setValue("Textbook9999")
        //getting the user
        let userDetails = Auth.auth().currentUser
        
        let userRef = ref?.child("textbooks").child((userDetails?.uid)!).childByAutoId()
        
        let textTitle = userRef?.child("Title")
        textTitle?.setValue(textbookTitle.text)
        let textAuthor = userRef?.child("Author")
        textAuthor?.setValue(textbookAuthor.text)
        let textCondition = userRef?.child("Condition")
        textCondition?.setValue(textbookCondition.text)
        let textISBN = userRef?.child("ISBN")
        textISBN?.setValue(textbookISBN.text)
        let textPrice = userRef?.child("Price")
        textPrice?.setValue(textbookPrice.text)
        let textEdition = userRef?.child("Edition")
        textEdition?.setValue(textbookEdition.text)
        let textPublisher = userRef?.child("Publisher")
        textPublisher?.setValue(textbookPublisher.text)
        let textYear = userRef?.child("Year")
        textYear?.setValue(textbookYear.text)
        
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
