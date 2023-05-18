//
//  ShowViewController.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/08/16.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ShowViewController: UIViewController {

    @IBOutlet weak var showqr: UIImageView!
    let user = Auth.auth().currentUser
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowOpacity = 0.2
        setURL()
        navigationItem.hidesBackButton = true
        }
        
        
        // Do any additional setup after loading the view.
    
    func setURL(){
        
        let user = Auth.auth().currentUser
        if let user = user {
            let userUid = user.uid
            let QR = userUid
            generateQR(url: QR, uiImage: showqr)
        }
    }
    
    func generateQR(url: String, uiImage: UIImageView){
        let url = url
        let data = url.data(using: .utf8)!
        let qr = CIFilter(name: "CIQRCodeGenerator", parameters: ["inputMessage": data, "inputCorrectionLevel": "M"])!
        let sizeTransform = CGAffineTransform(scaleX: 1, y: 1) // 白枠をつける
                uiImage.image = UIImage(ciImage:qr.outputImage!.transformed(by: sizeTransform))
        
    }
  
    
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
               // let index = self.navigationController!.viewControllers.count - 3
                //self.navigationController?.popToViewController(self.navigationController!.viewControllers[index], animated: true)

                
                let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "tabVC") as! tabbarController
                self.navigationController?.pushViewController(nextViewController, animated: false)
            }else{
                self.navigationController?.popViewController(animated: true)
            }
            
            }
        }
    }
    


}
