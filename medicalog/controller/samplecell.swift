//
//  samplecell.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/09/01.
//

import UIKit
import FoldingCell

class samplecell: FoldingCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func animationDuration(_ itemIndex:NSInteger, type:AnimationType)-> TimeInterval {
            let durations = [0.26, 0.2, 0.2]
            return durations[itemIndex]
        }

}
