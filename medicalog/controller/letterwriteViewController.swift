//
//  letterwriteViewController.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/08/28.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import TextFieldEffects

class letterwriteViewController: UIViewController {
    
    @IBOutlet weak var y: UIButton!
    @IBOutlet weak var o: UIButton!
    @IBOutlet weak var r: UIButton!
    @IBOutlet weak var p: UIButton!
    @IBOutlet weak var b: UIButton!
    @IBOutlet weak var g: UIButton!
    
    var lettercolor =  "W"
    
    @IBOutlet weak var lettername: HoshiTextField!
    @IBOutlet weak var letter: UITextView!
    let user = Auth.auth().currentUser
    @IBOutlet weak var kanryou: UIButton!
    let changelook = changeLookClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changelook.changeButton(button: y)
        changelook.changeButton(button: o)
        changelook.changeButton(button: r)
        changelook.changeButton(button: p)
        changelook.changeButton(button: b)
        changelook.changeButton(button: g)
        
        letter.layer.cornerRadius = 20.0
        letter.layer.masksToBounds = true
        letter.layer.shadowColor = UIColor(red: 0.13, green: 0.70, blue: 0.67, alpha: 1.0).cgColor
        letter.layer.shadowRadius = 8
        letter.layer.shadowOffset = CGSize(width: 2, height: 2)
        letter.layer.shadowOpacity = 0.5
        letter.layer.masksToBounds = false
        
        kanryou.layer.shadowColor = UIColor.black.cgColor
        kanryou.layer.shadowRadius = 4
        kanryou.layer.shadowOffset = CGSize(width: 2, height: 2)
        kanryou.layer.shadowOpacity = 0.2

        letter.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
    }
    
    
    @IBAction func tappedy(_ sender: Any) {
        
        lettercolor = "Y"
        letter.layer.shadowColor = UIColor(red: 0.98, green: 1, blue: 0.36, alpha: 1.0).cgColor
        
        
    }
    
    @IBAction func tappedo(_ sender: Any) {
        
        lettercolor = "O"
        letter.layer.shadowColor = UIColor(red: 0.99, green: 0.71, blue: 0.45, alpha: 1.0).cgColor
        
    }
    
    @IBAction func tappedr(_ sender: Any) {
        
        lettercolor = "R"
        letter.layer.shadowColor = UIColor(red: 1, green: 0.59, blue: 0.59, alpha: 1.0).cgColor
        
    }
    
    @IBAction func tappedp(_ sender: Any) {
        
        lettercolor = "P"
        letter.layer.shadowColor = UIColor(red: 0.99, green: 0.66, blue: 1.0, alpha: 1.0).cgColor
        
    }
    
    @IBAction func tappedb(_ sender: Any) {
        
        lettercolor = "B"
        letter.layer.shadowColor = UIColor(red: 0.70, green: 0.77, blue: 1.0, alpha: 1.0).cgColor
        
    }
    
    @IBAction func tappedg(_ sender: Any) {
        
        lettercolor = "G"
        letter.layer.shadowColor = UIColor(red: 0.53, green: 1.0, blue: 0.87, alpha: 1.0).cgColor
        
    }
    
    
    @IBAction func finished(_ sender: Any) {
        let formatter = DateFormatter()
        let day7 = Date()
        formatter.dateFormat = "yyyy年 M月d日"
        let showday7 = formatter.string(from: day7)
        let textname = lettername.text
        let text = letter.text
        if let user = user {
            Firestore.firestore().collection("users").document(user.uid).getDocument{(snap, error) in if let error = error {
                print("error")
                
            }
            guard let data = snap?.data() else { return }
            let familyid = data["familyid"]  as! String
                print("familyidは" + familyid)
                Firestore.firestore().collection(familyid).addDocument(data: ["lettername" : textname, "letter": text, "date":Date().timeIntervalSince1970, "date1": showday7, "color": self.lettercolor]) { (error) in if error != nil{
                    return
                }
                    
                }
                
            }
        }
        
        
        
        
        
        self.navigationController?.popViewController(animated: true)
        
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
