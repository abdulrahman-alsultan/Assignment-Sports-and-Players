//
//  SportTableViewCell.swift
//  Sport
//
//  Created by admin on 29/12/2021.
//

import UIKit

class SportTableViewCell: UITableViewCell {

    @IBOutlet weak var sportName: UILabel!
    var delegate: ImagePickerDelegate?
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var addBtn: UIButton!
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    @IBAction func addImage(_ sender: Any) {
        delegate?.pickImage(indexPath: indexPath!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
