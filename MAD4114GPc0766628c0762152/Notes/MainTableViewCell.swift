//
//  MainTableViewCell.swift
//  MAD4114GPc0766628c0762152
//
//  Created by SanDEV on 2020-01-17.
//  Copyright © 2020 SanDEV. All rights reserved.
//


import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setNote(note: Note) {
        titleLabel.text = note.title
        descriptionLabel.text = note.details
        
        let date = DateFormatter()
        date.dateFormat = "MM/dd/yy/ h:mm a"
        let dateSaved = date.string(from: note.date as! Date)
        dateLabel.text = dateSaved
    }
    


}

