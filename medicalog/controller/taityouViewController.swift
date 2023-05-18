//
//  taityouViewController.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/10/08.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class taityouViewController: UIViewController {

    
    @IBOutlet weak var darusa: UITextView!
    @IBOutlet weak var itami: UITextView!
    @IBOutlet weak var hakike: UITextView!
    @IBOutlet weak var syokuyoku: UITextView!
    @IBOutlet weak var iki: UITextView!
    @IBOutlet weak var hatunetu: UITextView!
    @IBOutlet weak var suimin: UITextView!
    @IBOutlet weak var sibire: UITextView!
    @IBOutlet weak var seisin: UITextView!
    @IBOutlet weak var geri: UITextView!
    let user = Auth.auth().currentUser
    
    var no1 = ""
    var no2 = ""
    var no3 = ""
    var no4 = ""
    var no5 = ""
    var no6 = ""
    var no7 = ""
    var no8 = ""
    var no9 = ""
    var no10 = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = user {
            Firestore.firestore().collection("users").document(user.uid).getDocument{(snap, error) in if let error = error {
                    print("error")
                
                }
                guard let data = snap?.data() else { return }
                let familyid = data["familyid"]  as! String
                Firestore.firestore().collection(familyid).document("taityouSetting").getDocument{(snap, error) in if let error = error {
                        print("error")
                    
                    }
                    guard let taityoudata = snap?.data() else {
                        return }
                    
                    self.no1 = taityoudata["1"] as! String
                    self.no2 = taityoudata["2"] as! String
                    self.no3 = taityoudata["3"] as! String
                    self.no4 = taityoudata["4"] as! String
                    self.no5 = taityoudata["5"] as! String
                    self.no6 = taityoudata["6"] as! String
                    self.no7 = taityoudata["7"] as! String
                    self.no8 = taityoudata["8"] as! String
                    self.no9 = taityoudata["9"] as! String
                    self.no10 = taityoudata["10"] as! String
                    self.darusa.text = self.no1
                    self.itami.text = self.no2
                    self.hakike.text = self.no3
                    self.syokuyoku.text = self.no4
                    self.iki.text = self.no5
                    self.hatunetu.text = self.no6
                    self.suimin.text = self.no7
                    self.sibire.text = self.no8
                    self.seisin.text = self.no9
                    self.geri.text = self.no10
                    
                    
                    }
                
                }

        }
        
        changelook(textfield: darusa)
        changelook(textfield: itami)
        changelook(textfield: hakike)
        changelook(textfield: syokuyoku)
        changelook(textfield: iki)
        changelook(textfield: hatunetu)
        changelook(textfield: suimin)
        changelook(textfield: sibire)
        changelook(textfield: seisin)
        changelook(textfield: geri)

        self.darusa.delegate = self
        self.itami.delegate = self
        self.hakike.delegate = self
        self.syokuyoku.delegate = self
        self.iki.delegate = self
        self.hatunetu.delegate = self
        self.suimin.delegate = self
        self.sibire.delegate = self
        self.seisin.delegate = self
        self.geri.delegate = self
        
        darusa.isEditable = false
        itami.isEditable = false
        hakike.isEditable = false
        syokuyoku.isEditable = false
        iki.isEditable = false
        hatunetu.isEditable = false
        suimin.isEditable = false
        sibire.isEditable = false
        seisin.isEditable = false
        geri.isEditable = false
        
        

        // Do any additional setup after loading the view.
    }
    
    
    func changelook(textfield: UITextView){
        textfield.layer.cornerRadius = 5
        textfield.layer.masksToBounds = true
        textfield.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
        textfield.layer.shadowRadius = 5
        textfield.layer.shadowOffset = CGSize(width: 2, height: 2)
        textfield.layer.shadowOpacity = 0.3
        textfield.layer.masksToBounds = false
    }
    
    
    @IBAction func edit(_ sender: Any) {
        
        darusa.isEditable = true
        itami.isEditable = true
        hakike.isEditable = true
        syokuyoku.isEditable = true
        iki.isEditable = true
        hatunetu.isEditable = true
        suimin.isEditable = true
        sibire.isEditable = true
        seisin.isEditable = true
        geri.isEditable = true
        
    }
    
    
    
    @IBAction func finished(_ sender: Any) {
        if darusa.text != nil && itami.text != nil && hakike.text != nil && syokuyoku.text != nil && iki.text != nil && hatunetu.text != nil && suimin.text != nil && sibire.text != nil && seisin.text != nil && geri.text != nil{
            no1 = darusa.text
            no2 = itami.text
            no3 = hakike.text
            no4 = syokuyoku.text
            no5 = iki.text
            no6 = hatunetu.text
            no7 = suimin.text
            no8 = sibire.text
            no9 = seisin.text
            no10 = geri.text
            
            if let user = user {
                Firestore.firestore().collection("users").document(user.uid).getDocument{(snap, error) in if let error = error {
                    print("a")
                
                }
                guard let data = snap?.data() else { return }
                let familyid = data["familyid"]  as! String
                    Firestore.firestore().collection(familyid).document("taityouSeting").getDocument { (snap, error) in if let error = error {
                        print("error")
                    }
                        guard let settingdata = snap?.data() else {return}
                        //ここ
                        
                    }
                    Firestore.firestore().collection(familyid).document("taityouSetting").updateData(["1": self.no1, "2": self.no2, "3": self.no3, "4": self.no4, "5": self.no5, "6": self.no6, "7": self.no7, "8": self.no8, "9": self.no9, "10": self.no10])
                    self.darusa.isEditable = false
                    self.itami.isEditable = false
                    self.hakike.isEditable = false
                    self.syokuyoku.isEditable = false
                    self.iki.isEditable = false
                    self.hatunetu.isEditable = false
                    self.suimin.isEditable = false
                    self.sibire.isEditable = false
                    self.seisin.isEditable = false
                    self.geri.isEditable = false
                    self.navigationController?.popViewController(animated: true)

                }
            }else{
                
                alert(title: "変更できません", message: "入力してください", actiontitle: "OK")
                
                
            }
        }
    }
    
    func alert(title:String,message:String,actiontitle:String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: actiontitle, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    
    

}

extension taityouViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let existingLines = textView.text.components(separatedBy: .newlines)//既に存在する改行数
        let newLines = text.components(separatedBy: .newlines)//新規改行数
        let linesAfterChange = existingLines.count + newLines.count - 1 //最終改行数。-1は編集したら必ず1改行としてカウントされるから。
        return linesAfterChange <= 1 && textView.text.count + (text.count - range.length) <= 5
    }
}
