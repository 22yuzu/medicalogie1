//
//  ViewController.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/07/28.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import TextFieldEffects


class ViewController: UIViewController, UITextFieldDelegate {
    
    //メールアドレス、パスワード、ユーザーネーム

    @IBOutlet weak var registerMail: HoshiTextField!
    @IBOutlet weak var registerPassword: HoshiTextField!
    @IBOutlet weak var registerUsername: HoshiTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("aaaaaa")
        
        //UITextFieldのデリゲート
        registerMail.delegate = self
        registerPassword.delegate = self
        registerUsername.delegate = self
        
        //loginのナビゲーションバー"back"の削除
        self.navigationItem.backButtonDisplayMode = .minimal

        }
    
    @IBAction func signup(_ sender: Any) {
        
        if let mail = registerMail.text,
           let password = registerPassword.text,
           let username = registerUsername.text {
           
            //firebaseAuthにメールアドレスとパスワードで登録
           Auth.auth().createUser(withEmail: mail, password: password, completion: { (result, error) in
               
               if let user = result?.user {
                   print("ユーザー登録完了 uid" + user.uid)
                   //firestoreのUsersコレクションにuidで追加
                   Firestore.firestore().collection("users").document(user.uid).setData([
                    
                    "username":username,
                    "mailadress":mail,
                    "password":password,
                    "patient":"Yes"
                    
                   ], completion: {error in if let error = error {
                       //firestoreのコレクションへの追加が失敗した場合
                       print("FireStore新規登録失敗" + error.localizedDescription)
                       let dialog = UIAlertController(title: "新規登録失敗", message: error.localizedDescription, preferredStyle: .alert)
                       dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                       self.present(dialog, animated: true, completion: nil)
                       
                   }
                       
                       else {
                       
                       print("ユーザー作成完了 name:" + username)
                       // 成功した場合の画面遷移(HomeViewControllerに)
                       
                       let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "showOrVC") as! ShowOrViewController
                       self.navigationController?.pushViewController(nextViewController
                                                                     , animated: true)
                           UserDefaults.standard.setValue(false, forKey: "familyOK")
                       
                   }
                       
                   })
               }else if let error = error {
                   
                   //firebase authにメールアドレス、パスワードの登録が失敗した場合
                   print("Firebase Auth 新規登録失敗" + error.localizedDescription)
                   let dialog = UIAlertController(title: "新規登録失敗", message: error.localizedDescription, preferredStyle: .alert)
                   dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   self.present(dialog, animated: true, completion: nil)
               }
              
               
           })
            
           
            
        }
    }
    

}

