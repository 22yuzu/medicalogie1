//
//  plushospitalViewController.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/08/29.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class plushospitalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var datePicker = UIDatePicker()
    let user = Auth.auth().currentUser
    @IBOutlet weak var tuindate: UIButton!
    
    @IBOutlet weak var choseDate: UIDatePicker!
    
    
    @IBOutlet weak var inputmemo: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tuindate.layer.cornerRadius = 10
        tuindate.layer.shadowColor = UIColor.black.cgColor
        tuindate.layer.shadowRadius = 4
        tuindate.layer.shadowOffset = CGSize(width: 2, height: 2)
        tuindate.layer.shadowOpacity = 0.3

        // Do any additional setup after loading the view.
    }
    //MARK:-画像を貼るボタン
        var picker: UIImagePickerController! = UIImagePickerController()
    
    @IBAction func imagebutton(_ sender: Any) {
        //PhotoLibraryから画像を選択
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        //デリゲートを設定する
        picker.delegate = self
        //現れるピッカーNavigationBarの文字色を設定する
        picker.navigationBar.tintColor = UIColor.white
        //現れるピッカーNavigationBarの背景色を設定する
        picker.navigationBar.barTintColor = UIColor.gray
        //ピッカーを表示する
        present(picker, animated: true, completion: nil)
        
    }
   
    @IBAction func getdate(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年 M月d日"
        let selecteddate = formatter.string(from: choseDate.date)
        print(selecteddate)
        if let user = user {
            Firestore.firestore().collection("users").document(user.uid).getDocument{(snap, error) in if let error = error {
                print(error)
                print("a")
            }
                guard let data = snap?.data() else { return }
                print("ここまで来ました")
                let familyid = data["familyid"] as! String
                print("familyidは" + familyid)
                Firestore.firestore().collection(familyid).document("hospital").getDocument { (snap, error) in if let error = error {
                    print("a")
                    Firestore.firestore().collection(familyid).document("hospital").setData(["1" : selecteddate, "number": 1])
                }
                
                    guard let data1 = snap?.data() else{
                        print("c")
                        Firestore.firestore().collection(familyid).document("hospital").setData(["1" : selecteddate, "number": 1])
                        return }
                    print("b")
                    var datanumber = data1["number"] as! Int
                    datanumber = datanumber + 1
                    Firestore.firestore().collection(familyid).document("hospital").updateData([String(datanumber): selecteddate, "number": datanumber])
                }
                
                
            }
        }
        
        //self.navigationController?.popViewController(animated: true)
        self.navigationController?.popViewController(animated: true)
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "tabVC") as! tabbarController
        self.navigationController?.pushViewController(nextViewController, animated: false)

        
    }
    
    

}

