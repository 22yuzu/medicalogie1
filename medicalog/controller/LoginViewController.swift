//
//  LoginViewController.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/07/31.
//

import UIKit
import Firebase
import FirebaseAuth
import TextFieldEffects

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //メールアドレスとパスワード,パスワードを忘れた方
    @IBOutlet weak var loginmail: HoshiTextField!
    @IBOutlet weak var loginpassword: HoshiTextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginmail.delegate = self
        loginpassword.delegate = self
        // Do any additional setup after loading the view.
    }
    
    //パスワードを忘れた方ボタンが押された時(パスワードリセット)
    @IBAction func forgotpassword(_ sender: Any) {
        let forgotpasswordAlert = UIAlertController(title: "パスワードをリセット", message: "メールアドレスを入力してください", preferredStyle: .alert)
        forgotpasswordAlert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        forgotpasswordAlert.addAction(UIAlertAction(title: "リセット", style: .default, handler: { (action) in let resetMail = forgotpasswordAlert.textFields?.first?.text
            Auth.auth().sendPasswordReset(withEmail: resetMail!, completion: { (error) in DispatchQueue.main.async {
                if error == nil {
                    self.alert(title: "メッセージを送信しました", message: "メールでパスワードの再設定を行ってください", actiontitle: "OK")
                }else{
                    self.alert(title: "エラー", message: "このメールアドレスは登録されてません。", actiontitle: "OK")
                }
            }})
        }))
        forgotpasswordAlert.addTextField{(textField) in textField.placeholder = "メールアドレス"}
        self.present(forgotpasswordAlert, animated: true, completion: nil)
    }
    
    //ログインボタンが押されたとき
    @IBAction func login(_ sender: Any) {
        
        if let mail = loginmail.text,
           let password = loginpassword.text {
            Auth.auth().signIn(withEmail: mail, password: password) {(user, error) in if error == nil {
                //成功した時（ホーム画面に移動）
                let user = Auth.auth().currentUser
                if let user = user{
                Firestore.firestore().collection("users").document(user.uid).getDocument{(snap, error) in if let error = error {
                        print("error")
                    
                    }
                    guard let data = snap?.data() else { return }
                    if data["familyid"] != nil{
                        
                        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "tabVC") as! tabbarController
                        let ViewController2 = self.storyboard?.instantiateViewController(withIdentifier: "accountVC")
                        let nextViewController3 = self.storyboard?.instantiateViewController(withIdentifier: "almem")
                        
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                        
                    }else{
                        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "showOrVC") as! ShowOrViewController
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }
                    }
                }
                
                print("ログインに成功しました")
            }else{
                self.alert(title: "エラー", message: "メールアドレスまたはパスワードが間違っています", actiontitle: "OK")
            }
            }
        }else{
            self.alert(title: "エラー", message: "入力されてない箇所があります。", actiontitle: "OK")
        }
        
    }
    
    //アラート関数
    func alert(title:String,message:String,actiontitle:String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: actiontitle, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    
    
    
    
        

    
   

}
