//
//  ShowOrViewController.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/08/16.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ShowOrViewController: UIViewController {

    @IBOutlet weak var patient: UIButton!
    @IBOutlet weak var family: UIButton!
    let user = Auth.auth().currentUser
    @IBOutlet weak var showLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print()

        patient.layer.shadowColor = UIColor.black.cgColor
        patient.layer.shadowRadius = 8
        patient.layer.shadowOffset = CGSize(width: 4, height: 4)
        patient.layer.shadowOpacity = 0.4
        
        family.layer.shadowColor = UIColor.black.cgColor
        family.layer.shadowRadius = 8
        family.layer.shadowOffset = CGSize(width: 4, height: 4)
        family.layer.shadowOpacity = 0.4
        
        if let user = user {
            Firestore.firestore().collection("users").document(user.uid).getDocument{(snap, error) in if let error = error {
                print("a")
                
            }
                guard let data = snap?.data() else {
                    self.navigationItem.hidesBackButton = true
                    print("b")
                    return }
                if data["familyid"] != nil{
                    self.navigationItem.hidesBackButton = false
                    self.showLabel.text = ""
                    print("c")
                }else{
                    self.navigationItem.hidesBackButton = true
                    print("d")
                }
            
                
                
            }
        }
        
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
