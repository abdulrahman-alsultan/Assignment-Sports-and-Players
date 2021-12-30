//
//  PlayerTableViewCell.swift
//  Sport
//
//  Created by admin on 30/12/2021.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerAge: UILabel!
    @IBOutlet weak var playerHeight: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
