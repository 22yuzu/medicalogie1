//
//  WriteViewController.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/08/09.
//

import UIKit

class WriteViewController: UIViewController {

    @IBOutlet weak var nikki: UIButton!
    @IBOutlet weak var tegami: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nikki.layer.shadowColor = UIColor.black.cgColor
        nikki.layer.shadowRadius = 8
        nikki.layer.shadowOffset = CGSize(width: 4, height: 4)
        nikki.layer.shadowOpacity = 0.4
        
        tegami.layer.shadowColor = UIColor.black.cgColor
        tegami.layer.shadowRadius = 8
        tegami.layer.shadowOffset = CGSize(width: 4, height: 4)
        tegami.layer.shadowOpacity = 0.4

        // Do any additional setup after loading the view.
    }
    

 
}
