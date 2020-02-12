//
//  LecturesCell.swift
//  O6U-Mobile-App
//
//  Created by Mohamed Ahmed on 12/30/19.
//  Copyright © 2019 Ahmed Ramzy. All rights reserved.
//

import UIKit

class LecturesCell: UITableViewCell {
    @IBOutlet var lectureNumber: UILabel!
    @IBOutlet var lectureDate: UILabel!
    @IBOutlet var studentsCount: UILabel!
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var countView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        countView.layer.cornerRadius = countView.frame.size.width/2
          countView.clipsToBounds = true
        
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 15
        
        // Initialization code

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
