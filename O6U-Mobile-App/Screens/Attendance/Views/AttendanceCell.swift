//
//  AttendanceCell.swift
//  O6U-Mobile-App
//
//  Created by Mohamed Ahmed on 12/30/19.
//  Copyright © 2019 Ahmed Ramzy. All rights reserved.
//

import UIKit

class AttendanceCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var attendCount: UILabel!
    @IBOutlet var absentCount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
