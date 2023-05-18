//
//  DiaryViewController.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/08/09.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class DiaryViewController: UIViewController {
    
    let user = Auth.auth().currentUser

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
       }

    
    
    func loadDiary(familyid:String){
        
        Firestore.firestore().collection(familyid).order(by: "date").addSnapshotListener { (snapShot, error) in
            if error != nil{
                return
            }
            if let snapshotDoc = snapShot?.documents{
                for doc in snapshotDoc {
                    let data = doc.data()
                    if let lettername = data["lettername"]{
                        
                    }
                    if let letter = data["letter"]{
                        
                    }
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
