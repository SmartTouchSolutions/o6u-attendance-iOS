//
//  SubjectsCell.swift
//  O6U-Mobile-App
//
//  Created by Mohamed Ahmed on 12/26/19.
//  Copyright © 2019 Ahmed Ramzy. All rights reserved.
//

import UIKit

class SubjectsCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var countView: UIView!
    @IBOutlet var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        countView.layer.cornerRadius = countView.frame.size.width/2
        countView.clipsToBounds = true
        
        
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 40
        containerView.layer.maskedCorners = [.layerMaxXMaxYCorner]

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
