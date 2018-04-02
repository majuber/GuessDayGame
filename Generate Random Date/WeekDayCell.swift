//
//  DateCollectionViewCell.swift
//  Generate Random Date


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
