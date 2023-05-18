//
//  FirebaseData.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/10/05.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class FirebaseData{
    init(){
        
    }
    
    let user = Auth.auth().currentUser
    func getimage() {
        if let user = user {
            Firestore.firestore().collection("users").document(user.uid).getDocument{(snap, error) in if let error = error {
                    print("a")
                
                }
                guard let data = snap?.data() else { return }
                let profileimage = data["userprofileimage"]  as! String
                print (profileimage)
                
                }

        }
    }
    

    
    
    
}
