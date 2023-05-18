//
//  sendtoModel.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/08/17.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth




class sendtoModel {
    
    
    init(){
    }
        let user = Auth.auth().currentUser
        func sendProfileImage(data:Data){
            let image = UIImage(data:data)
            let profileImage = image?.jpegData(compressionQuality: 0.1)
            let imageRef = Storage.storage().reference().child("profileImage").child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpg")
            imageRef.putData(profileImage!, metadata: nil) { metaData, error in
                if error != nil {
                    print(error.debugDescription)
                    return
                }
                
                imageRef.downloadURL { url, error in
                    if error != nil {
                        print(error.debugDescription)
                        return
                    }
                    
                    
                   
                    if let user = self.user {
                        Firestore.firestore().collection("users").document(user.uid).updateData(["userprofileimage" : url?.absoluteString], completion: {error in if let error = error{
                            //firestoreへの送信が失敗したとき
                            print("データの送信に失敗しました")
                        }else{
                            print("成功しました")
                      }})
                        
                    }
                        
                    
                    UserDefaults.standard.setValue(url?.absoluteString, forKey:"userImage")
                   
                }
            }
        }
        
    
    
}


