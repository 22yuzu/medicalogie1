//
//  changeLookClass.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/10/09.
//

import Foundation
import UIKit

class changeLookClass{
    
    func changeButton(button: UIButton){
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowOpacity = 0.3
    }
    
}
