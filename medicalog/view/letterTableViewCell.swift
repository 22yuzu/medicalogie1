//
//  letterTableViewCell.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/10/09.
//

import UIKit

class letterTableViewCell: UITableViewCell {

   
    @IBOutlet weak var mainBackground: UIView!
    @IBOutlet weak var shadowLayer: UIView!
    @IBOutlet weak var letterName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
