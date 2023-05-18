//
//  MemberViewController.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/08/14.
//

import UIKit

class MemberViewController: UIViewController {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.delegate =  self
      //  tableView.dataSource = self
      //  tableView.reloadData()
    }
    
    //func numberOfSections(in tableView: UITableView) -> Int {
       // return 1
    //}
    
  //  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return textArray.count
 //   }
    //セルの再利用
   // func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      //  let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //cell.textlabel?.text = textArray[indexPath.row]
        //cell.imageView!.image = UIImage(named:"")
        //return cell
        
   // }
    
   
    //セルの高さ
   // func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //    return view.frame.size.height/8
//    }
    
    //tableView.reloadData
    

   
    

}
