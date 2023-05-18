//
//  shadowView.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/09/20.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class shadowView: UIView {
    
    let user = Auth.auth().currentUser
    
    override var bounds: CGRect {
            didSet {
                setupShadow()
            }
        }

    private func setupShadow(){
        
        
            self.layer.cornerRadius = 15
            self.layer.shadowOffset = CGSize(width: 0, height: 0)
        //shadowRadiusも変えとく
            //self.layer.shadowRadius = 5
        //shadowOpacityを変える
            //self.layer.shadowOpacity = 0.3
            self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale = UIScreen.main.scale
    }

}
