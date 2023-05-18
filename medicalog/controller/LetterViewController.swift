//
//  LetterViewController.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/09/04.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LetterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var selectSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var chose = "new"
    let user = Auth.auth().currentUser
    var cellCount = 0
    var count1 = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "letterTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        if let user = user {
            Firestore.firestore().collection("users").document(user.uid).getDocument{(snap, error) in if let error = error {
                print("a")
                
            }
            guard let data = snap?.data() else { return }
            let familyid = data["familyid"]  as! String
                print("familyidは" + familyid)
                Firestore.firestore().collection(familyid).order(by: "date").addSnapshotListener { (snapShot, error) in
                    if error != nil{
                        return
                    }
                    if let snapshotDoc = snapShot?.documents{
                        var count = 0
                        for doc in snapshotDoc {
                            count += 1
                            let data = doc.data()
                            if let lettername = data["lettername"]{
                                print("新しい")
                                print(lettername)
                                
                                
                            }
                        }
                        self.cellCount = count
                        print(self.cellCount)
                        self.tableView.reloadData()
                    }
                }
            }
        }
    

        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func tappedSegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
                case 0:
                    print("選択")
                    chose = "new"
                    
                case 1:
                    print("old")
                    chose = "old"
                    
                default:
                    print("new")
                    chose = "new"
                    
                }
        tableView.reloadData()

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(cellCount)
        return cellCount
       }
    
       // ④セルの中身を設定するメソッド（必須）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // セルを取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! letterTableViewCell
        //let colorView = UIView()
                //colorView.backgroundColor = None
                //cell.selectedBackgroundView = colorView
        cell.mainBackground.layer.cornerRadius = 15
        cell.mainBackground.layer.masksToBounds = true
        //cell.backgroundColor = .systemGray6
        cell.shadowLayer.layer.shadowOpacity = 0.3
        cell.shadowLayer.layer.shadowRadius = 7
        
        if let user = user {
            Firestore.firestore().collection("users").document(user.uid).getDocument{(snap, error) in if let error = error {
                print("a")
                
            }
            guard let data = snap?.data() else { return }
            let familyid = data["familyid"]  as! String
                var lettername = ""
                print("familyidは" + familyid)
                if self.chose == "old"{
                Firestore.firestore().collection(familyid).order(by: "date").addSnapshotListener { (snapShot, error) in
                    if error != nil{
                        return
                    }
                    if let snapshotDoc = snapShot?.documents{
                        var count2 = 0
                        self.count1 += 1
                        for doc in snapshotDoc {
                            count2 += 1
                            print(self.count1)
                            print(count2)
                            let data = doc.data()
                            if self.count1 == count2{
                            lettername = data["lettername"] as! String
                            let lettercolor = data["color"] as! String
                                print(lettercolor)
                                if lettercolor == "W"{
                                    cell.shadowLayer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                                }
                                if lettercolor == "Y"{
                                    cell.shadowLayer.backgroundColor = UIColor(red: 0.98, green: 1, blue: 0.36, alpha: 1)
                                }else if lettercolor == "O"{
                                    cell.shadowLayer.backgroundColor = UIColor(red: 0.99, green: 0.71, blue: 0.45, alpha: 1)
                                }else if lettercolor == "R"{
                                    cell.shadowLayer.backgroundColor = UIColor(red: 1, green: 0.59, blue: 0.59, alpha: 1)
                                }else if lettercolor == "P"{
                                    cell.shadowLayer.backgroundColor = UIColor(red: 0.99, green: 0.66, blue: 1.0, alpha: 1)
                                }else if lettercolor == "B" {
                                    cell.shadowLayer.backgroundColor = UIColor(red: 0.70, green: 0.77, blue: 1.0, alpha: 1)
                                }else{
                                    cell.shadowLayer.backgroundColor = UIColor(red: 0.53, green: 1.0, blue: 0.87, alpha: 1)
                                }
                            cell.letterName.text = lettername
                            print(lettername)
                            }
                        }
                    }
                }
                }else{
                    Firestore.firestore().collection(familyid).order(by: "date", descending: true).addSnapshotListener { (snapShot, error) in
                        if error != nil{
                            return
                        }
                        if let snapshotDoc = snapShot?.documents{
                            var count2 = 0
                            self.count1 += 1
                            for doc in snapshotDoc {
                                count2 += 1
                                let data = doc.data()
                                if let lettername = data["lettername"]{
                                    print("古い")
                                    print(lettername)
                                    if count2 == self.count1 {
                                        let lettercolor = data["color"] as! String
                                            if lettercolor == "Y"{
                                                cell.shadowLayer.backgroundColor = UIColor(red: 0.98, green: 1, blue: 0.36, alpha: 1.0)
                                            }else if lettercolor == "O"{
                                                cell.shadowLayer.backgroundColor = UIColor(red: 0.99, green: 0.71, blue: 0.45, alpha: 1.0)
                                            }else if lettercolor == "R"{
                                                cell.shadowLayer.backgroundColor = UIColor(red: 1, green: 0.59, blue: 0.59, alpha: 1.0)
                                            }else if lettercolor == "P"{
                                                cell.shadowLayer.backgroundColor = UIColor(red: 0.99, green: 0.66, blue: 1.0, alpha: 1.0)
                                            }else if lettercolor == "B" {
                                                cell.shadowLayer.backgroundColor = UIColor(red: 0.70, green: 0.77, blue: 1.0, alpha: 1.0)
                                            }else{
                                                cell.shadowLayer.backgroundColor = UIColor(red: 0.53, green: 1.0, blue: 0.87, alpha: 1.0)
                                            }
                                    cell.letterName!.text = lettername as! String
                                    }
                                    
                                }
                            }
                        }
                    }
                    
                }
                    
            }
                    
            }
        self.count1 = 0
           // セルに値を設定する
        
          // cell.textLabel!.text = CountryList[indexPath.row]
           return cell
      }

    
    // セルがタップされた時の処理
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          print("タップ")
          UserDefaults.standard.setValue(indexPath.row, forKey: "tapplace")
          UserDefaults.standard.setValue(self.chose, forKey: "newOr")
          print(indexPath.row)
          let vc = self.storyboard?.instantiateViewController(withIdentifier: "contentVC") as! lettercontentViewController
          self.navigationController?.pushViewController(vc, animated: true)
        
      }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 90
        }
    
    
    
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


