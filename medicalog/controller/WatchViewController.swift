//
//  WatchViewController.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/08/16.
//

import UIKit
import Foundation
import AVFoundation
import FirebaseAuth
import FirebaseFirestore

class WatchViewController: UIViewController {
    
    @IBOutlet weak var qrview: UIView!
    let myQRCodeReader = qrcoderead()
    let user = Auth.auth().currentUser
    var yesOr = false
    var familyok = false

    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowOpacity = 0.2
        
        myQRCodeReader.delegate = self
        myQRCodeReader.setupCamera(view: qrview)
                //読み込めるカメラ範囲
        myQRCodeReader.readRange()
        yesOr = true
        navigationItem.hidesBackButton = true
        
    }

        // Do any additional setup after loading the view.
    
    
    @IBAction func backbutton(_ sender: Any) {
        
        if let user = user{
        Firestore.firestore().collection("users").document(user.uid).getDocument { (snap, error) in
            if let error = error {
                fatalError("\(error)")
                self.navigationController?.popViewController(animated: true)
            }
            guard let data = snap?.data() else {
                self.navigationController?.popViewController(animated: true)
                return }
            if data["familyid"] != nil{
                //self.navigationController?.popViewController(animated: true)
                //let index = self.navigationController!.viewControllers.count - 3
                //self.navigationController?.popToViewController(self.navigationController!.viewControllers[index], animated: true)
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "tabVC") as! tabbarController
            //self.present(nextViewController, animated: true, completion: nil)
            self.navigationController?.pushViewController(nextViewController, animated: false)
            }else{
                self.navigationController?.popViewController(animated: true)
            }
            
            }
        }
        
        
    }
    

}
extension WatchViewController: AVCaptureMetadataOutputObjectsDelegate{
    //対象を認識、読み込んだ時に呼ばれる
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        //一画面上に複数のQRがある場合、複数読み込むが今回は便宜的に先頭のオブジェクトを処理
        if yesOr == true{
        if let metadata = metadataObjects.first as? AVMetadataMachineReadableCodeObject{
            let barCode = myQRCodeReader.previewLayer.transformedMetadataObject(for: metadata) as! AVMetadataMachineReadableCodeObject
            //読み込んだQRを映像上で枠を囲む。
            myQRCodeReader.qrView.frame = barCode.bounds
            //QRデータを表示
            if let str = metadata.stringValue {
                print(str)
                if let user = user {
                    let db = Firestore.firestore()
                    let userRef = db.collection("users").document(user.uid)
                   
                    db.collection("users").document(str).getDocument { (snap, error) in
                        if let error = error {
                            fatalError("\(error)")
                        }
                        guard let data = snap?.data() else { return }
                        print(data)
                        if data["familyid"] == nil{
                            let familyuuid = UUID().uuidString
                            db.collection("users").document(str).updateData(["familyid" : familyuuid])
                            userRef.updateData(["familyid" : familyuuid])
                            db.collection(familyuuid).document("number").setData(["number":2])
                            db.collection(familyuuid).document("familymember").setData(["1" : str, "2":user.uid])
                            db.collection(familyuuid).document("taityouSetting").setData(["1" : "だるさ", "2" : "痛み", "3" : "吐き気", "4" : "食欲のなさ", "5" : "息苦しさ", "6" : "発熱", "7" : "睡眠の悪さ", "8" : "痺れ", "9" : "精神", "10" : "下痢"])
                            userRef.updateData(["patient" : "No"])
                            self.alert(title: "追加完了", message: "メンバーを追加しました", actiontitle: "OK")
                            self.yesOr = false
                            UserDefaults.standard.setValue(true, forKey: "familyOK")
                            
                            //一回読み取ったら画面遷移
                            //self.navigationController?.popViewController(animated: true)
                            
                        }else{
                            print("family２人目以上")
                            let family = data["familyid"] as! String
                            Firestore.firestore().collection(family).document("number").getDocument { (snap, error) in
                                if let error = error {
                                    fatalError("\(error)")
                                }
                                guard let familydata = snap?.data() else { return }
                                    var familynumber = familydata["number"] as! Int
                                    familynumber = familynumber + 1
                                    db.collection(family).document("familymember").updateData([String(familynumber) : user.uid])
                                    userRef.updateData(["familyid" : family])
                                    Firestore.firestore().collection(family).document("number").updateData(["number" : familynumber])
                                    self.alert(title: "追加完了", message: "メンバーを追加しました", actiontitle: "OK")
                                    userRef.updateData(["patient" : "No"])
                                    //self.navigationController?.popViewController(animated: true)
                                    //let index = self.navigationController!.viewControllers.count - 5
                                    //self.navigationController?.popToViewController(self.navigationController!.viewControllers[index], animated: true)
                                    //let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "almemVC") as! allmemberViewController
                                    //self.navigationController?.pushViewController(nextViewController, animated: false)
                                    UserDefaults.standard.setValue(true, forKey: "familyOK")
                                    
                                    
                                    self.yesOr = false
                                    
                                }
                            }
                        }
                    }
                
                
                
                
            }
        }
    }
    }
    
    
    
    
    
    func alert(title:String,message:String,actiontitle:String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: actiontitle, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    
    
    
}
