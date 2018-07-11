//
//  DetailsViewController.swift
//  Textbooks Buy and Sell
//
//  Created by Jefferson Santos on 6/19/18.
//  Copyright © 2018 Jefferson Santos. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var textbookImg: UIImageView!
    @IBOutlet weak var textbookDetails: UILabel!
    
    var image = UIImage()
    var textTitle = " "
    var textAuthor = " "
//    var textISBN = " "
    var textCondition = " "
    var textPrice = " "
//    var textEdition = " "
//    var textPublisher = " "
//    var textYear = " "
    var textEmail = " "

    override func viewDidLoad() {
        super.viewDidLoad()
    
        textbookDetails.text = "Title: \(textTitle) \nAuthor: \(textAuthor) \nCondition: \(textCondition) \nPrice: U$ \(textPrice) \nEmail: \(textEmail)"
        
        textbookImg.image = image
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        let subject = "About \"\(textTitle)\" Textbook"
        let body = "Hi, is \(textTitle) textbook still Avaiable? \n\nThanks!"
        let coded = "mailto:\(textEmail)?subject=\(subject)&body=\(body)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        if let emailURL: NSURL = NSURL(string: coded!) {
            if UIApplication.shared.canOpenURL(emailURL as URL) {
                UIApplication.shared.openURL(emailURL as URL)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
