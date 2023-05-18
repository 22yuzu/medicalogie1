//
//  allmemberViewController.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/09/19.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore
import SDWebImage

class allmemberViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var memberplus: UIButton!
    let user = Auth.auth().currentUser
    var cellCount = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "familyCellTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        navigationItem.title = "家族メンバー"
        self.navigationController?.navigationBar.titleTextAttributes = [
                // 文字の色
                .foregroundColor: UIColor(red: 0.13, green: 0.70, blue: 0.67, alpha: 1.0).cgColor
            ]

        
        if let user = user {
            Firestore.firestore().collection("users").document(user.uid).getDocument{(snap, error) in if let error = error {
                print("a")
                
            }
                guard let data = snap?.data() else { return }
            let familyid = data["familyid"]  as! String
                print("familyidは" + familyid)
                Firestore.firestore().collection(familyid).document("number").getDocument{(snap, error) in if let error = error {
                    
                    print("エラーです")
                    
                    
                }
                    guard let a = snap?.data() else {
                        
                        return
                    }
                    self.cellCount = a["number"] as! Int//うまく行った時
                    print(self.cellCount)
                    self.tableView.reloadData()
                    
                    }
                    
                    
                }
                
            }
        
        
        

        memberplus.layer.shadowColor = UIColor.black.cgColor
        memberplus.layer.shadowRadius = 3
        memberplus.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        memberplus.layer.shadowOpacity = 0.3
        memberplus.layer.cornerRadius = 35
        //navigationItem.rightBarButtonItem = editButtonItem
        
    }
    
    //並び替えは無効に
    
    /*func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    //編集ぼたんが押された時編集可能に
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.isEditing = editing
    }
    */
    //セクションの中のセルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(cellCount)
        return cellCount
    }
    //セルの取得
    var placeCount = 0
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // セルを取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! familyCellTableViewCell
        cell.mainBackground.layer.cornerRadius = 15
        cell.mainBackground.layer.masksToBounds = true
        //cell.backgroundColor = .systemGray6
        cell.shadowLayer.layer.shadowOpacity = 0.5
        cell.shadowLayer.layer.shadowRadius = 5
        cell.shadowLayer.layer.shadowColor = UIColor(red: 0.27, green: 0.80, blue: 0.79, alpha: 1.0).cgColor
        cell.shadowLayer.backgroundColor = UIColor(red: 0.27, green: 0.80, blue: 0.79, alpha: 1.0)
        

        
        if let user = user {
            Firestore.firestore().collection("users").document(user.uid).getDocument{(snap, error) in if let error = error {
                print("error")
                
            }
                guard let data = snap?.data() else { return }
            let familyid = data["familyid"]  as! String
                print("familyidは" + familyid)
                Firestore.firestore().collection(familyid).document("familymember").getDocument{(snap, error) in if let error = error {
                    
                    print("エラーです")
                    //エラーが起こった時(familymemberが存在しない)
                    
                }
                    guard let a = snap?.data() else {
                        
                        return
                    }
                    //うまく行った時
                    self.placeCount += 1
                    if a[String(self.placeCount)] != nil{
                        var imanohito = a[String(self.placeCount)] as! String
                        Firestore.firestore().collection("users").document(imanohito).getDocument { (snap, error) in
                            if let error = error {
                                fatalError("\(error)")
                            }
                            guard let data = snap?.data() else { return }
                            cell.userName.text = data["username"] as! String
                            if data["userprofileimage"] != nil{
                                let imageString = data["userprofileimage"] as! String
                                cell.profileImage.sd_setImage(with: URL(string: imageString), completed: nil)
                                print("URLは" + imageString)
                            }else{
                                //cell.profileImage.image = UIImage(systemName: "person.fill")
                                //cell.profileImage.preferredSymbolConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: .systemMint)
                                cell.profileImage.backgroundColor = UIColor(red: 0.13, green: 0.70, blue: 0.67, alpha: 1.0)
                            }
                            
                            
                            /*if UserDefaults.standard.object(forKey: "userImage") != nil {
                                imageString = UserDefaults.standard.object(forKey: "userImage") as! String
                                profileImageView.sd_setImage(with: URL(string: imageString), completed: nil)
                                print("URLは" + imageString)
                            }
                            */
                            
                        }
                        
                        //cell.textLabel!.text = a[String(self.placeCount)] as! String
                    }
                    
                    
                }
                
            }
        }
            
            // セルに表示する値を設定する
            
            
            return cell
    }
    //削除可能なセル
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.row == 0{
            return false
        }else{
            return true
        }
    }
    //編集モード中のみ削除可能
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing {
            return UITableViewCell.EditingStyle.delete
        } else {
            return UITableViewCell.EditingStyle.none
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 110
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
