//
//  HomeViewController.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/08/09.
//

import UIKit
import Foundation
import FSCalendar
import CalculateCalendarLogic
import RealmSwift
import FirebaseFirestore
import FirebaseAuth

class HomeViewController: UIViewController, FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance, UITextViewDelegate{
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var taityou: UIButton!
    @IBOutlet weak var tuin: UIButton!
 
    var tuinlist = [String]()
    
    let user = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        /*let gradientLayer = CAGradientLayer()
        gradientLayer.frame = taityou.bounds
        gradientLayer.cornerRadius = taityou.bounds.midY
        gradientLayer.colors = [UIColor(red: 0.13, green: 0.70, blue: 0.67, alpha: 1.0).cgColor, UIColor(red: 0.53, green: 1.0, blue: 0.87, alpha: 1.0).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

        taityou.layer.insertSublayer(gradientLayer, at: 0)
        */
       
        calendar.layer.cornerRadius = 18
        calendar.layer.shadowColor = UIColor.black.cgColor
        calendar.layer.shadowRadius = 4
        calendar.layer.shadowOffset = CGSize(width: 2, height: 2)
        calendar.layer.shadowOpacity = 0.3
        //calendar.layer.masksToBounds = true
        points.layer.shadowColor = UIColor.black.cgColor
        points.layer.shadowRadius = 4
        points.layer.shadowOffset = CGSize(width: 2, height: 2)
        points.layer.shadowOpacity = 0.3
        points.layer.shadowOpacity = 0.3
        points.layer.masksToBounds = true
        taityou.layer.shadowColor = UIColor.black.cgColor
        taityou.layer.shadowRadius = 4
        taityou.layer.shadowOffset = CGSize(width: 2, height: 2)
        taityou.layer.shadowOpacity = 0.3
        tuin.layer.shadowColor = UIColor.black.cgColor
        tuin.layer.shadowRadius = 4
        tuin.layer.shadowOffset = CGSize(width: 2, height: 2)
        tuin.layer.shadowOpacity = 0.3
        
        self.calendar.dataSource = self
        self.calendar.delegate = self
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年 M月d日"
        let today = formatter.string(from: Date())
        print(today)
        if UserDefaults.standard.object(forKey:today) != nil{
            let t = UserDefaults.standard.object(forKey:today)
            print(t)
        }
        if let user = user {
            Firestore.firestore().collection("users").document(user.uid).getDocument{(snap, error) in if let error = error {
                print("a")
                
            }
            guard let data = snap?.data() else { return }
                if data["familyid"] != nil{
                let familyid = data["familyid"]  as! String
                    print("familyidは" + familyid)
                    
                    //通院日の配列を用意
                    Firestore.firestore().collection(familyid).document("hospital").getDocument { (snap, error) in
                        if let error = error {
                            print("エラー")
                            //通院日がなかった時
                            
                            
                        }
                        guard let b = snap?.data() else{
                            
                            //通院日がなかったとき
                            
                            
                            return
                        }
                        
                        var hospitalnumber = b["number"] as! Int
                        print(hospitalnumber)
                        for i in 1..<hospitalnumber+1{
                            var  c = b[String(i)] as! String
                            print(c)
                            self.tuinlist.append(c)
                            self.calendar.reloadData()
                        }
                        
                        
                    }
                    
                    Firestore.firestore().collection(familyid).document("taityouSetting").getDocument { (snap, error) in if let error = error {
                        print("error")
                    }
                        guard let settingdata = snap?.data() else {return}
                        var no1 = settingdata["1"] as! String
                        var no2 = settingdata["2"] as! String
                        var no3 = settingdata["3"] as! String
                        var no4 = settingdata["4"] as! String
                        var no5 = settingdata["5"] as! String
                        var no6 = settingdata["6"] as! String
                        var no7 = settingdata["7"] as! String
                        var no8 = settingdata["8"] as! String
                        var no9 = settingdata["9"] as! String
                        var no10 = settingdata["10"] as! String
                        Firestore.firestore().collection(familyid).document(today).getDocument{(snap, error) in if let error = error {
                        print(error)
                    }
                        guard let a = snap?.data() else {
                            return
                        }
                        if a[no1] != nil && a[no2] != nil && a[no3] != nil && a[no4] != nil && a[no5] != nil && a[no6] != nil && a[no7] != nil && a[no8] != nil && a[no9] != nil && a[no10] != nil{
                        let bennpi = a[no1] as! Int
                        let geri = a[no2] as! Int
                        let darusa = a[no3] as! Int
                        let hakike = a[no4] as! Int
                        let hatunetu = a[no5] as! Int
                        let itami = a[no6] as! Int
                        let sibire = a[no7] as! Int
                        let suimin = a[no8] as! Int
                        let syokuyoku = a[no9] as! Int
                        let iki = a[no10] as! Int
                        
                        self.points.text = String(100 - bennpi - geri - darusa - hakike - hatunetu - itami - sibire - suimin - syokuyoku - iki)
                            }
                            print(self.points)
                            
                            
                        
                        
                    }
                    }
                
                
            }
            }
        }
        
        
        
        

    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
        fileprivate lazy var dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
    // 祝日判定を行い結果を返すメソッド(True:祝日)
        func judgeHoliday(_ date : Date) -> Bool {
            //祝日判定用のカレンダークラスのインスタンス
            let tmpCalendar = Calendar(identifier: .gregorian)

            // 祝日判定を行う日にちの年、月、日を取得
            let year = tmpCalendar.component(.year, from: date)
            let month = tmpCalendar.component(.month, from: date)
            let day = tmpCalendar.component(.day, from: date)

            // CalculateCalendarLogic()：祝日判定のインスタンスの生成
            let holiday = CalculateCalendarLogic()

            return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
        }
        // date型 -> 年月日をIntで取得
        func getDay(_ date:Date) -> (Int,Int,Int){
            let tmpCalendar = Calendar(identifier: .gregorian)
            let year = tmpCalendar.component(.year, from: date)
            let month = tmpCalendar.component(.month, from: date)
            let day = tmpCalendar.component(.day, from: date)
            return (year,month,day)
        }

        //曜日判定(日曜日:1 〜 土曜日:7)
        func getWeekIdx(_ date: Date) -> Int{
            let tmpCalendar = Calendar(identifier: .gregorian)
            return tmpCalendar.component(.weekday, from: date)
        }

        // 土日や祝日の日の文字色を変える
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
            //祝日判定をする（祝日は赤色で表示する）
            if self.judgeHoliday(date){
                return UIColor(red: 0.13, green: 0.70, blue: 0.67, alpha: 1.0)
            }

            //土日の判定を行う（土曜日は青色、日曜日は赤色で表示する）
            let weekday = self.getWeekIdx(date)
            if weekday == 1 {   //日曜日
                return UIColor(red: 0.13, green: 0.70, blue: 0.67, alpha: 1.0)
            }
            else if weekday == 7 {  //土曜日
                return UIColor(red: 0.13, green: 0.70, blue: 0.67, alpha: 1.0)
            }

            return nil
        }
    

    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年 M月d日"
        let selecteddate = formatter.string(from: date)
        print("選択された日は" + selecteddate)
        let nextView = storyboard?.instantiateViewController(withIdentifier: "selectdate") as! selectedViewController
              //""内には、SecondViewControllerのstoryBoard IDを入力します
              //nextView.modalTransitionStyle = .crossDissolve
              //nextView.modalPresentationStyle = .fullScreen

              //SecondViewController.swift内の変数recieverに文字列"Hello, world!"を代入
              nextView.date1 = selecteddate

              //遷移を実行
              self.present(nextView, animated: true, completion: nil)
        
        print(date)
        
    }
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年 M月d日"
        let selecteddate = formatter.string(from: date)
        var hasEvent = false
        for tuinbi in tuinlist{
            print(tuinlist)
            if tuinbi == selecteddate{
                hasEvent = true
                print(selecteddate)
            }else if hasEvent == true{
                hasEvent = true
                print(selecteddate)
            }else{
                hasEvent = false
                //print(selecteddate)
            }
        }
        
        if hasEvent == true{
            return 1
        }else{
            return 0
        }
    }
    
    
    
    

}
