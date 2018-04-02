//
//  DateCollectionViewCell.swift
//  Generate Random Date
//
//  Created by Palavesakumar Mahalingam on 29/03/18.
//  Copyright © 2018 Opteamix. All rights reserved.
//

import UIKit

class WeekDayCell: UICollectionViewCell {
    
    @IBOutlet weak var weekDayLabel: UILabel!
    
    override func awakeFromNib() {
        let height = weekDayLabel.frame.size.height
        let width = weekDayLabel.frame.size.width
        weekDayLabel.layer.cornerRadius = height/2
        weekDayLabel.clipsToBounds = true
    }
}
