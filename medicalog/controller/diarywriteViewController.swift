//
//  diarywriteViewController.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/08/28.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class diarywriteViewController: UIViewController {
    
    
    @IBOutlet weak var kimoti: UISlider!
    @IBOutlet weak var dateselect: UIDatePicker!
    @IBOutlet weak var inputtext: UITextView!
    let user = Auth.auth().currentUser
    @IBOutlet weak var kanryou: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //inputtext.layer.borderColor = UIColor(red: 0.13, green: 0.70, blue: 0.67, alpha: 1.0).cgColor
                
                // 枠の幅
        //inputtext.layer.borderWidth = 2.0
                
                // 枠を角丸にする
        inputtext.layer.cornerRadius = 20.0
        inputtext.layer.masksToBounds = true
        inputtext.layer.shadowColor = UIColor(red: 0.13, green: 0.70, blue: 0.67, alpha: 1.0).cgColor
        inputtext.layer.shadowRadius = 8
        inputtext.layer.shadowOffset = CGSize(width: 2, height: 2)
        inputtext.layer.shadowOpacity = 0.5
        inputtext.layer.masksToBounds = false
        
        kanryou.layer.shadowColor = UIColor.black.cgColor
        kanryou.layer.shadowRadius = 4
        kanryou.layer.shadowOffset = CGSize(width: 2, height: 2)
        kanryou.layer.shadowOpacity = 0.2

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func finished(_ sender: Any) {
        let kimotiValue:Int = Int(kimoti.value)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年 M月d日"
        let selecteddate = formatter.string(from: dateselect.date)
        print("選択された日は" + selecteddate)
        
        if inputtext.text != nil {
            UserDefaults.standard.setValue(inputtext.text, forKey:selecteddate)
            if let user = user {
                Firestore.firestore().collection("users").document(user.uid).getDocument{(snap, error) in if let error = error {
                    print("a")
                    
                }
                guard let data = snap?.data() else { return }
                let familyid = data["familyid"]  as! String
                let name = data["username"] as! String
                    print("familyidは" + familyid)
                    Firestore.firestore().collection(familyid).document(selecteddate).getDocument{(snap, error) in if let error = error {
                        print("a")
                        //選択された日がなかった場合
                        Firestore.firestore().collection(familyid).document(selecteddate).setData(["nikinumber" : 1, "1": ["body":self.inputtext.text, "kimoti":kimotiValue, "name":name, "useruid":user.uid]])
                    }
                    guard let a = snap?.data() else {
                        print("b")
                        Firestore.firestore().collection(familyid).document(selecteddate).setData(["nikinumber" : 1, "1": ["body":self.inputtext.text, "kimoti":kimotiValue, "name":name, "useruid":user.uid]])
                        return }
                        if a["nikinumber"] != nil{
                        var nikinumber = a["nikinumber"] as! Int
                        nikinumber += 1
                        Firestore.firestore().collection(familyid).document(selecteddate).updateData(["nikinumber" : nikinumber])
                            Firestore.firestore().collection(familyid).document(selecteddate).updateData([String(nikinumber): ["body":self.inputtext.text, "kimoti":kimotiValue, "name":name, "useruid":user.uid]])
                        }else{
                            print("c")
                            Firestore.firestore().collection(familyid).document(selecteddate).updateData(["nikinumber" : 1])
                            Firestore.firestore().collection(familyid).document(selecteddate).updateData([ "1": ["body":self.inputtext.text, "kimoti":kimotiValue, "name":name, "useruid":user.uid]])
                        }
                        
                        
                    }
                    
                    
                }
            }
            
            self.navigationController?.popViewController(animated: true)
            
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
