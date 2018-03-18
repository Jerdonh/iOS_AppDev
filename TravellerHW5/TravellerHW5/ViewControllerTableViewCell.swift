//
//  ViewControllerTableViewCell.swift
//  TravellerHW5
//
//  Created by Jerdon Helgeson on 2/13/18.
//  Copyright © 2018 Jerdon Helgeson. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    //properties
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myDestination: UILabel!
    @IBOutlet weak var myDates: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
