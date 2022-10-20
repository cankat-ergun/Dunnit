//
//  TableViewCell.swift
//  Dunnit-Storyboard
//
//  Created by Argun Cankat Ergun on 11.10.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var tableViewCellLabel: UILabel!
    @IBOutlet weak var tableViewCell: UIView!
    @IBOutlet weak var checkButton: UIButton!
    @IBAction func completeButtonPressed(_ sender: UIButton) {
        if buttonPressed {
            buttonPressed = false
            checkButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            buttonPressed = true
            checkButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        }
    }
    var buttonPressed: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
  
    
    
    
   
    
}


