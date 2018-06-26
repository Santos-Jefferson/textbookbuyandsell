//
//  SearchTableViewCell.swift
//  Textbooks Buy and Sell
//
//  Created by Jefferson Santos on 6/21/18.
//  Copyright © 2018 Jefferson Santos. All rights reserved.
//

import UIKit
import Firebase

class SearchTableViewCell: UITableViewCell {
    var ref: DatabaseReference!
    
    var name:NSArray = []
    var imageArr:NSArray = []
    
    
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ref = Database.database().reference()
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
