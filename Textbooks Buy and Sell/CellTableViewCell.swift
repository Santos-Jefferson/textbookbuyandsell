//
//  CellTableViewCell.swift
//  Textbooks Buy and Sell
//
//  Created by Jefferson Santos on 7/4/18.
//  Copyright © 2018 Jefferson Santos. All rights reserved.
//

import UIKit

class CellTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
