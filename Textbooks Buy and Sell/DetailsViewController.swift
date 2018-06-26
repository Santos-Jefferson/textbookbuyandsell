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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textbookDetails.text = "/(Title: Test123), /(Author: Jeffe Santos)"
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
