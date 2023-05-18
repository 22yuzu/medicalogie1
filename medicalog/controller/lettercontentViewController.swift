//
//  lettercontentViewController.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/09/04.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class lettercontentViewController: UIViewController {

    @IBOutlet weak var titleview: UILabel!
    @IBOutlet weak var letterview: UITextView!
    @IBOutlet weak var dateview: UILabel!
    let user = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        letterview.isEditable = false
        letterview.layer.cornerRadius = 20.0
        letterview.layer.masksToBounds = true
        letterview.layer.shadowColor = UIColor(red: 0.13, green: 0.70, blue: 0.67, alpha: 1.0).cgColor
        letterview.layer.shadowRadius = 8
        letterview.layer.shadowOffset = CGSize(width: 2, height: 2)
        letterview.layer.shadowOpacity = 0.5
        letterview.layer.masksToBounds = false
        /*letterview.layer.borderWidth = 2.0
                
                // 枠を角丸にする
        letterview.layer.cornerRadius = 20.0
        letterview.layer.masksToBounds = true
        letterview.layer.borderColor = UIColor(red: 0.13, green: 0.70, blue: 0.67, alpha: 1.0).cgColor
         */
        if let user = user {
            Firestore.firestore().collection("users").document(user.uid).getDocument{(snap, error) in if let error = error {
                print("a")
                
            }
            guard let data = snap?.data() else { return }
            let familyid = data["familyid"]  as! String
                print("familyidは" + familyid)
                let tapplace = UserDefaults.standard.object(forKey: "tapplace") as! Int
                let newOr = UserDefaults.standard.object(forKey: "newOr") as! String
                if newOr == "old" {
                    Firestore.firestore().collection(familyid).order(by: "date").addSnapshotListener { (snapShot, error) in
                        if error != nil{
                            return
                        }
                        if let snapshotDoc = snapShot?.documents{
                            var count = 0
                            for doc in snapshotDoc {
                                let data = doc.data()
                                if count == tapplace{
                                    self.titleview.text = data["lettername"] as! String
                                    self.letterview.text = data["letter"] as! String
                                    self.dateview.text = data["date1"] as! String
                                    let lettercolor = data["color"] as! String
                                    if lettercolor == "W"{
                                        self.letterview.layer.shadowColor  = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
                                    }
                                        if lettercolor == "Y"{
                                            self.letterview.layer.shadowColor  = UIColor(red: 0.98, green: 1, blue: 0.36, alpha: 1.0).cgColor
                                        }else if lettercolor == "O"{
                                            self.letterview.layer.shadowColor  = UIColor(red: 0.99, green: 0.71, blue: 0.45, alpha: 1.0).cgColor
                                        }else if lettercolor == "R"{
                                            self.letterview.layer.shadowColor = UIColor(red: 1, green: 0.59, blue: 0.59, alpha: 1.0).cgColor
                                        }else if lettercolor == "P"{
                                            self.letterview.layer.shadowColor  = UIColor(red: 0.99, green: 0.66, blue: 1.0, alpha: 1.0).cgColor
                                        }else if lettercolor == "B" {
                                            self.letterview.layer.shadowColor  = UIColor(red: 0.70, green: 0.77, blue: 1.0, alpha: 1.0).cgColor
                                        }else{
                                            self.letterview.layer.shadowColor  = UIColor(red: 0.53, green: 1.0, blue: 0.87, alpha: 1.0).cgColor
                                        }
                                    

                                }
                                count += 1
                            }
                        }
                    }
                }else{
                    Firestore.firestore().collection(familyid).order(by: "date", descending: true).addSnapshotListener { (snapShot, error) in
                        if error != nil{
                            return
                        }
                        if let snapshotDoc = snapShot?.documents{
                            var count = 0
                            for doc in snapshotDoc {
                                let data = doc.data()
                                if count == tapplace{
                                    self.titleview.text = data["lettername"] as! String
                                    self.letterview.text = data["letter"] as! String
                                    self.dateview.text = data["date1"] as! String
                                    let lettercolor = data["color"] as! String
                                        if lettercolor == "Y"{
                                            self.letterview.layer.shadowColor  = UIColor(red: 0.98, green: 1, blue: 0.36, alpha: 1.0).cgColor
                                        }else if lettercolor == "O"{
                                            self.letterview.layer.shadowColor  = UIColor(red: 0.99, green: 0.71, blue: 0.45, alpha: 1.0).cgColor
                                        }else if lettercolor == "R"{
                                            self.letterview.layer.shadowColor = UIColor(red: 1, green: 0.59, blue: 0.59, alpha: 1.0).cgColor
                                        }else if lettercolor == "P"{
                                            self.letterview.layer.shadowColor  = UIColor(red: 0.99, green: 0.66, blue: 1.0, alpha: 1.0).cgColor
                                        }else if lettercolor == "B" {
                                            self.letterview.layer.shadowColor  = UIColor(red: 0.70, green: 0.77, blue: 1.0, alpha: 1.0).cgColor
                                        }else{
                                            self.letterview.layer.shadowColor  = UIColor(red: 0.53, green: 1.0, blue: 0.87, alpha: 1.0).cgColor
                                        }

                                }
                                count += 1
                            }
                        }
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
