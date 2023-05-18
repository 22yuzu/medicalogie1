//
//  SettingViewController.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/08/12.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import SDWebImage

class SettingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    

  
    @IBOutlet weak var profileImageShadow: UIView!
    @IBOutlet weak var logoutbutton: UIButton!
    @IBOutlet weak var familybutton: UIButton!
    @IBOutlet weak var keep: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var showUsername: UILabel!
    @IBOutlet weak var showMailadress: UILabel!
    @IBOutlet weak var patientOr: UILabel!
    var SendToModel = sendtoModel()
    let user = Auth.auth().currentUser
     
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let user = user {
            
            
            keep.layer.shadowColor = UIColor.black.cgColor
            keep.layer.shadowRadius = 3
            keep.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
            keep.layer.shadowOpacity = 0.3
            familybutton.layer.shadowColor = UIColor.black.cgColor
            familybutton.layer.shadowRadius = 3
            familybutton.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
            familybutton.layer.shadowOpacity = 0.3
            logoutbutton.layer.shadowColor = UIColor.black.cgColor
            logoutbutton.layer.shadowRadius = 3
            logoutbutton.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
            logoutbutton.layer.shadowOpacity = 0.3
            profileImageShadow.layer.cornerRadius = 85
            profileImageShadow.layer.shadowColor = UIColor.black.cgColor
            profileImageShadow.layer.shadowRadius = 4
            profileImageShadow.layer.shadowOffset = CGSize(width: 2, height: 2)
            profileImageShadow.layer.shadowOpacity = 0.3
            
            
            
            Firestore.firestore().collection("users").document(user.uid).getDocument { (snap, error) in
                if let error = error {
                    fatalError("\(error)")
                }
                guard let data = snap?.data() else { return }
                self.showUsername.text = data["username"] as! String
                if data["patient"] as! String == "Yes"{
                    self.patientOr.text = "患者"
                }else{
                    self.patientOr.text = "家族"
                }
            }
        }
       
        
        
        
        let checkModel = checkModel()
        checkModel.showCheck()
        
        var imageString = ""
        
        
        if let user = user {
            let email = user.email
            showMailadress.text = email
            
        }
        if UserDefaults.standard.object(forKey: "userImage") != nil {
            imageString = UserDefaults.standard.object(forKey: "userImage") as! String
            profileImageView.sd_setImage(with: URL(string: imageString), completed: nil)
            print("URLは" + imageString)
        }
        print(imageString)
    
        
        
        

    
    }
    
    
    
 
    
  
       
    
    //カメラ立ち上げメソッド
        
    func doCamera(){
            
        let sourceType:UIImagePickerController.SourceType = .camera
            
            //カメラ利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera){
                
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
                
                
        }
            
    }
        
        //アルバム
    func doAlbum(){
            
        let sourceType:UIImagePickerController.SourceType = .photoLibrary
            
            //カメラ利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
                
                
        }
            
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            
            if info[.originalImage] as? UIImage != nil{
                
                let selectedImage = info[.originalImage] as! UIImage
                profileImageView.image = selectedImage
                picker.dismiss(animated: true, completion: nil)
                print("画像選択完了")
                
            }else{
                print("画像選択失敗")
            }
            
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            
            picker.dismiss(animated: true, completion: nil)
            
        }
        
        
        //アラート
        func showAlert(){
            
            let alertController = UIAlertController(title: "選択", message: "どちらを使用しますか?", preferredStyle: .actionSheet)
            
            let action1 = UIAlertAction(title: "カメラ", style: .default) { (alert) in
                
                self.doCamera()
                
            }
            let action2 = UIAlertAction(title: "アルバム", style: .default) { (alert) in
                
                self.doAlbum()
                
            }

            let action3 = UIAlertAction(title: "キャンセル", style: .cancel)
            
            
            alertController.addAction(action1)
            alertController.addAction(action2)
            alertController.addAction(action3)
            self.present(alertController, animated: true, completion: nil)
            
            
        }
    
    
    //タップイメージが押された時にプロフィール画像を設定（firestoregeに画像保存、userdefalutにurl保存）
    @IBAction func tapImage(_ sender: Any) {
        showAlert()
        if let image = profileImageView.image{
        let data = image.jpegData(compressionQuality: 1.0)
            self.SendToModel.sendProfileImage(data: data!)
        }
        
                    
    }
    
    
    @IBAction func saveImage(_ sender: Any) {
        if let image = profileImageView.image{
        let data = image.jpegData(compressionQuality: 1.0)
        self.SendToModel.sendProfileImage(data: data!)
        }
    }
    
    //パスワードを変更ボタンが押されたときにパスワードを変更する
    @IBAction func changePassword(_ sender: Any) {
        
        let changepasswordAlert = UIAlertController(title: "パスワードをリセット", message: "メールアドレスを入力してください", preferredStyle: .alert)
        changepasswordAlert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        changepasswordAlert.addAction(UIAlertAction(title: "リセット", style: .default, handler: { (action) in let resetMail = changepasswordAlert.textFields?.first?.text
            Auth.auth().sendPasswordReset(withEmail: resetMail!, completion: { (error) in DispatchQueue.main.async {
                if error == nil {
                    self.alert(title: "メッセージを送信しました", message: "メールでパスワードの再設定を行ってください", actiontitle: "OK")
                }else{
                    self.alert(title: "エラー", message: "このメールアドレスは登録されてません。", actiontitle: "OK")
                }
            }})
        }))
        changepasswordAlert.addTextField{(textField) in textField.placeholder = "メールアドレス"}
        self.present(changepasswordAlert, animated: true, completion: nil)
        
        
    }
    
    //ログアウトボタンが押された時にログアウトする
    
    @IBAction func logoutbutton(_ sender: Any) {
        if Auth.auth().currentUser != nil {
                 //ログアウト成功
                 do {
                     try Auth.auth().signOut()
                     self.alert(title: "ログアウト成功", message: "ログアウトしました", actiontitle: "OK")
                     exit(0)
                 //ログアウト失敗
                 } catch let signOutError as NSError {
                     print (signOutError)
                 }
        }
    }
    
    
    //アラートメソッド
    func alert(title:String,message:String,actiontitle:String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: actiontitle, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
    }

   

}
