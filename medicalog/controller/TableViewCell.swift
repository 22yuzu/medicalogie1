//
//  TableViewCell.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/09/20.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var profileimage: UIImageView!
    @IBOutlet weak var mainBackground: UIView!
    @IBOutlet weak var shadowlayer: UIView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var content: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
