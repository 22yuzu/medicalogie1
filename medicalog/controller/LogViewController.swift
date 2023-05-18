//
//  LogViewController.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/08/09.
//

import UIKit
import Charts
import FirebaseAuth
import FirebaseFirestore
import Foundation

class LogViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var shadowview: UIView!
    
    @IBOutlet weak var hyouzi: UIButton!
    @IBOutlet weak var chosepicker: UIPickerView!
    @IBOutlet weak var showview: UIView!
    @IBOutlet weak var chartsView: LineChartView!
    
    @IBOutlet weak var sharebutton: UIButton!
   
    var datalist = ["痛み", "だるさ", "吐き気", "食欲のなさ", "息苦しさ", "発熱", "睡眠の悪さ", "痺れ", "下痢回数", "精神"]
    var datelist: [Int] = [0, 0, 0, 0, 0, 0, 0]
    var datechose = "week"
    let user = Auth.auth().currentUser
    var q = "何も選択されてません"
    var dateCount = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = user {
            Firestore.firestore().collection("users").document(user.uid).getDocument{(snap, error) in if let error = error {
                print("a")
                
            }
            guard let data = snap?.data() else { return }
            let familyid = data["familyid"]  as! String
                print("familyidは" + familyid)
                let db = Firestore.firestore().collection(familyid)
                db.document("taityouSetting").getDocument {(snap, error) in if let error = error{
                    print("エラーです")
                }
                    guard let settingdata = snap?.data() else{ return }
                    self.datalist[0] = settingdata["1"] as! String
                    self.datalist[1] = settingdata["2"] as! String
                    self.datalist[2] = settingdata["3"] as! String
                    self.datalist[3] = settingdata["4"] as! String
                    self.datalist[4] = settingdata["5"] as! String
                    self.datalist[5] = settingdata["6"] as! String
                    self.datalist[6] = settingdata["7"] as! String
                    self.datalist[7] = settingdata["8"] as! String
                    self.datalist[8] = settingdata["9"] as! String
                    self.datalist[9] = settingdata["10"] as! String
                }
            }
        }
        
        
        
        
        hyouzi.layer.shadowColor = UIColor.black.cgColor
        hyouzi.layer.shadowRadius = 4
        hyouzi.layer.shadowOffset = CGSize(width: 2, height: 2)
        hyouzi.layer.shadowOpacity = 0.2
        
        sharebutton.layer.shadowColor = UIColor.black.cgColor
        sharebutton.layer.shadowRadius = 4
        sharebutton.layer.shadowOffset = CGSize(width: 2, height: 2)
        sharebutton.layer.shadowOpacity = 0.2
        
        chosepicker.layer.shadowColor = UIColor.black.cgColor
        chosepicker.layer.shadowRadius = 4
        chosepicker.layer.shadowOffset = CGSize(width: 2, height: 2)
        chosepicker.layer.shadowOpacity = 0.2
        chosepicker.layer.masksToBounds = true
        
        shadowview.layer.cornerRadius = 18
        shadowview.layer.shadowColor = UIColor.black.cgColor
        shadowview.layer.shadowRadius = 4
        shadowview.layer.shadowOffset = CGSize(width: 2, height: 2)
        shadowview.layer.shadowOpacity = 0.3
        
        chosepicker.delegate = self
        chosepicker.dataSource = self
        dateCount = 0
        

    }
    
    
   
    
    
    func numberOfComponents(in chosepicker: UIPickerView) -> Int {
            return 1
    }
    func pickerView(_ chosepicker: UIPickerView,
                        numberOfRowsInComponent component: Int) -> Int {
            return datalist.count
    }
    func pickerView(_ chosepicker: UIPickerView,
                       titleForRow row: Int,
                       forComponent component: Int) -> String? {
           
           return datalist[row]
    }
    
   
    
    
    var chosen = 1
   // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        if row == 0{
            chosen = 1
            //q = "痛み"
        }
        if row == 1{
            //q = "だるさ"
            chosen = 2
        }
        if row == 2{
            //q = "吐き気"
            chosen = 3
        }
        if row == 3{
           // q = "食欲のなさ"
            chosen = 4
        }
        if row == 4{
            //q = "息苦しさ"
            chosen = 5
        }
        if row == 5{
            //q = "発熱"
            chosen = 6
        }
        if row == 6 {
            //q = "睡眠の悪さ"
            chosen = 7
        }
        if row == 7{
            //q = "痺れ"
            chosen = 8
        }
        if row == 8{
            //q = "下痢回数"
            chosen = 9
        }
        if row == 9{
            //q = "精神"
            chosen = 10
        }
     
        var number1 = 0
        var number2 = 0
        var number3 = 0
        var number4 = 0
        var number5 = 0
        var number6 = 0
        var number7 = 0
        let formatter = DateFormatter()
        var gg = 7 * dateCount
        var aa = 7 * dateCount + 1
        var bb = 7 * dateCount + 2
        var cc = 7 * dateCount + 3
        var dd = 7 * dateCount + 4
        var ee = 7 * dateCount + 5
        var ff = 7 * dateCount + 6
        let day1 = Date(timeIntervalSinceNow: -Double((60*60*24*ff)))
        let day2 = Date(timeIntervalSinceNow: -Double((60*60*24*ee)))
        let day3 = Date(timeIntervalSinceNow: -Double((60*60*24*dd)))
        let day4 = Date(timeIntervalSinceNow: -Double((60*60*24*cc)))
        let day5 = Date(timeIntervalSinceNow: -Double((60*60*24*bb)))
        let day6 = Date(timeIntervalSinceNow: -Double((60*60*24*aa)))
        let day7 = Date(timeIntervalSinceNow: -Double((60*60*24*gg)))
        

        formatter.dateFormat = "yyyy年 M月d日"
        let showday1 = formatter.string(from: day1)
        let showday2 = formatter.string(from: day2)
        let showday3 = formatter.string(from: day3)
        let showday4 = formatter.string(from: day4)
        let showday5 = formatter.string(from: day5)
        let showday6 = formatter.string(from: day6)
        let showday7 = formatter.string(from: day7)
        if let user = user {
            Firestore.firestore().collection("users").document(user.uid).getDocument{(snap, error) in if let error = error {
                print("a")
                
            }
            guard let data = snap?.data() else { return }
            let familyid = data["familyid"]  as! String
                print("familyidは" + familyid)
                let db = Firestore.firestore().collection(familyid)
                db.document("taityouSetting").getDocument {(snap, error) in if let error = error{
                    print("エラーです")
                }
                    guard let settingdata = snap?.data() else{
                        return }
                    var taityouchosen = settingdata[String(self.chosen)] as! String
                    
                    db.document(showday1).getDocument{(snap, error) in if let error = error {
                        number1 = 0
                        print("エラーです")
                    }
                        guard let day1data = snap?.data() else{
                            number1 = 0
                            return }
                        if day1data[taityouchosen] != nil{
                        number1 = day1data[taityouchosen] as! Int
                        self.datelist[0] = number1
                        print(number1)
                        } else{
                            number1 = 0
                        }
                        
                    }
                    db.document(showday2).getDocument{(snap, error) in if let error = error {
                        number2 = 0
                    }
                        guard let day2data = snap?.data() else{
                            number2 = 0
                            return }
                        if day2data[taityouchosen] != nil{
                        number2 = day2data[taityouchosen] as! Int
                        self.datelist[1] = number2
                        }else{
                            number2 = 0
                        }
                    }
                    db.document(showday3).getDocument{(snap, error) in if let error = error {
                        number3 = 0
                    }
                        guard let day3data = snap?.data() else{
                            number3 = 0
                            return }
                        if day3data[taityouchosen] != nil{
                        number3 = day3data[taityouchosen] as! Int
                        self.datelist[2] = number3
                        }else{
                            number3 = 0
                        }
                        
                    }
                    db.document(showday4).getDocument{(snap, error) in if let error = error {
                        number4 = 0
                    }
                        guard let day4data = snap?.data() else{
                            number4 = 0
                            return }
                        if day4data[taityouchosen] != nil{
                        number4 = day4data[taityouchosen] as! Int
                        self.datelist[3] = number4
                        }else{
                            number4 = 0
                        }
                    }
                    db.document(showday5).getDocument{(snap, error) in if let error = error {
                        number5 = 0
                    }
                        guard let day5data = snap?.data() else{
                            number5 = 0
                            return }
                        if day5data[taityouchosen] != nil{
                        number5 = day5data[taityouchosen] as! Int
                        self.datelist[4] = number5
                        }else{
                            number5 = 0
                        }
                    }
                    db.document(showday6).getDocument{(snap, error) in if let error = error {
                        number6 = 0
                    }
                        guard let day6data = snap?.data() else{
                            number6 = 0
                            return }
                        if day6data[taityouchosen] != nil{
                        number6 = day6data[taityouchosen] as! Int
                        self.datelist[5] = number6
                        }else{
                            number6 = 0
                        }
                        
                    }
                    db.document(showday7).getDocument{(snap, error) in if let error = error {
                        number7 = 0
                    }
                        guard let day7data = snap?.data() else{
                            number7 = 0
                            return }
                        if day7data[taityouchosen] != nil{
                        number7 = day7data[taityouchosen] as! Int
                        self.datelist[6] = number7
                        print(self.datelist[6])
                            
                        }else{
                            number7 = 0
                        }}
                        var labels:[String] = ["1","2","3","4","5","6","7"]
                        let formatterJP = DateFormatter()
                                formatterJP.dateFormat = DateFormatter.dateFormat(fromTemplate: "dMEE", options: 0, locale: Locale(identifier: "ja_JP"))
                                formatterJP.timeZone = TimeZone(identifier:  "Asia/Tokyo")
                        var gg = 7 * self.dateCount
                        var aa = 7 * self.dateCount + 1
                        var bb = 7 * self.dateCount + 2
                        var cc = 7 * self.dateCount + 3
                        var dd = 7 * self.dateCount + 4
                        var ee = 7 * self.dateCount + 5
                        var ff = 7 * self.dateCount + 6
                        let day1 = Date(timeIntervalSinceNow: -Double((60*60*24*ff)))
                        let day2 = Date(timeIntervalSinceNow: -Double((60*60*24*ee)))
                        let day3 = Date(timeIntervalSinceNow: -Double((60*60*24*dd)))
                        let day4 = Date(timeIntervalSinceNow: -Double((60*60*24*cc)))
                        let day5 = Date(timeIntervalSinceNow: -Double((60*60*24*bb)))
                        let day6 = Date(timeIntervalSinceNow: -Double((60*60*24*aa)))
                        let day7 = Date(timeIntervalSinceNow: -Double((60*60*24*gg)))
                                
                        let time1 = "\(formatterJP.string(from: day1))"
                        let time2 = "\(formatterJP.string(from: day2))"
                        let time3 = "\(formatterJP.string(from: day3))"
                        let time4 = "\(formatterJP.string(from: day4))"
                        let time5 = "\(formatterJP.string(from: day5))"
                        let time6 = "\(formatterJP.string(from: day6))"
                        let time7 = "\(formatterJP.string(from: day7))"
                                
                        labels[0] = time1
                        labels[1] = time2
                        labels[2] = time3
                        labels[3] = time4
                        labels[4] = time5
                        labels[5] = time6
                        labels[6] = time7
                    print(self.datelist)
                    print(self.chosen)
                }
                
            }
            
        }
        
    }
    
    
    
    
    @IBAction func check(_ sender: Any) {
        
        
        getchart()
        
    }
    
    
    
    
    func getchart(){
        print(dateCount)
        var number1 = 0
        var number2 = 0
        var number3 = 0
        var number4 = 0
        var number5 = 0
        var number6 = 0
        var number7 = 0
        let formatter = DateFormatter()
        var gg = 7 * dateCount
        var aa = 7 * dateCount + 1
        var bb = 7 * dateCount + 2
        var cc = 7 * dateCount + 3
        var dd = 7 * dateCount + 4
        var ee = 7 * dateCount + 5
        var ff = 7 * dateCount + 6
        let day1 = Date(timeIntervalSinceNow: -Double((60*60*24*ff)))
        let day2 = Date(timeIntervalSinceNow: -Double((60*60*24*ee)))
        let day3 = Date(timeIntervalSinceNow: -Double((60*60*24*dd)))
        let day4 = Date(timeIntervalSinceNow: -Double((60*60*24*cc)))
        let day5 = Date(timeIntervalSinceNow: -Double((60*60*24*bb)))
        let day6 = Date(timeIntervalSinceNow: -Double((60*60*24*aa)))
        let day7 = Date(timeIntervalSinceNow: -Double((60*60*24*gg)))
        

        formatter.dateFormat = "yyyy年 M月d日"
        let showday1 = formatter.string(from: day1)
        let showday2 = formatter.string(from: day2)
        let showday3 = formatter.string(from: day3)
        let showday4 = formatter.string(from: day4)
        let showday5 = formatter.string(from: day5)
        let showday6 = formatter.string(from: day6)
        let showday7 = formatter.string(from: day7)
        if let user = user {
            Firestore.firestore().collection("users").document(user.uid).getDocument{(snap, error) in if let error = error {
                print("a")
                
            }
            guard let data = snap?.data() else { return }
            let familyid = data["familyid"]  as! String
                print("familyidは" + familyid)
                let db = Firestore.firestore().collection(familyid)
                db.document("taityouSetting").getDocument {(snap, error) in if let error = error{
                    print("エラーです")
                }
                    guard let settingdata = snap?.data() else{
                        return }
                    var taityouchosen = settingdata[String(self.chosen)] as! String
                    
                    db.document(showday1).getDocument{(snap, error) in if let error = error {
                        number1 = 0
                        print("エラーです")
                    }
                        guard let day1data = snap?.data() else{
                            number1 = 0
                            return }
                        if day1data[taityouchosen] != nil{
                        number1 = day1data[taityouchosen] as! Int
                        self.datelist[0] = number1
                        print(number1)
                        } else{
                            number1 = 0
                        }
                        
                    }
                    db.document(showday2).getDocument{(snap, error) in if let error = error {
                        number2 = 0
                    }
                        guard let day2data = snap?.data() else{
                            number2 = 0
                            return }
                        if day2data[taityouchosen] != nil{
                        number2 = day2data[taityouchosen] as! Int
                        self.datelist[1] = number2
                        }else{
                            number2 = 0
                        }
                    }
                    db.document(showday3).getDocument{(snap, error) in if let error = error {
                        number3 = 0
                    }
                        guard let day3data = snap?.data() else{
                            number3 = 0
                            return }
                        if day3data[taityouchosen] != nil{
                        number3 = day3data[taityouchosen] as! Int
                        self.datelist[2] = number3
                        }else{
                            number3 = 0
                        }
                        
                    }
                    db.document(showday4).getDocument{(snap, error) in if let error = error {
                        number4 = 0
                    }
                        guard let day4data = snap?.data() else{
                            number4 = 0
                            return }
                        if day4data[taityouchosen] != nil{
                        number4 = day4data[taityouchosen] as! Int
                        self.datelist[3] = number4
                        }else{
                            number4 = 0
                        }
                    }
                    db.document(showday5).getDocument{(snap, error) in if let error = error {
                        number5 = 0
                    }
                        guard let day5data = snap?.data() else{
                            number5 = 0
                            return }
                        if day5data[taityouchosen] != nil{
                        number5 = day5data[taityouchosen] as! Int
                        self.datelist[4] = number5
                        }else{
                            number5 = 0
                        }
                    }
                    db.document(showday6).getDocument{(snap, error) in if let error = error {
                        number6 = 0
                    }
                        guard let day6data = snap?.data() else{
                            number6 = 0
                            return }
                        if day6data[taityouchosen] != nil{
                        number6 = day6data[taityouchosen] as! Int
                        self.datelist[5] = number6
                        }else{
                            number6 = 0
                        }
                        
                    }
                    db.document(showday7).getDocument{(snap, error) in if let error = error {
                        number7 = 0
                    }
                        guard let day7data = snap?.data() else{
                            number7 = 0
                            return }
                        if day7data[taityouchosen] != nil{
                        number7 = day7data[taityouchosen] as! Int
                        self.datelist[6] = number7
                        print(self.datelist[6])
                            
                        }else{
                            number7 = 0
                        }}
                        var labels:[String] = ["1","2","3","4","5","6","7"]
                        let formatterJP = DateFormatter()
                                formatterJP.dateFormat = DateFormatter.dateFormat(fromTemplate: "dMEE", options: 0, locale: Locale(identifier: "ja_JP"))
                                formatterJP.timeZone = TimeZone(identifier:  "Asia/Tokyo")
                        var gg = 7 * self.dateCount
                        var aa = 7 * self.dateCount + 1
                        var bb = 7 * self.dateCount + 2
                        var cc = 7 * self.dateCount + 3
                        var dd = 7 * self.dateCount + 4
                        var ee = 7 * self.dateCount + 5
                        var ff = 7 * self.dateCount + 6
                        let day1 = Date(timeIntervalSinceNow: -Double((60*60*24*ff)))
                        let day2 = Date(timeIntervalSinceNow: -Double((60*60*24*ee)))
                        let day3 = Date(timeIntervalSinceNow: -Double((60*60*24*dd)))
                        let day4 = Date(timeIntervalSinceNow: -Double((60*60*24*cc)))
                        let day5 = Date(timeIntervalSinceNow: -Double((60*60*24*bb)))
                        let day6 = Date(timeIntervalSinceNow: -Double((60*60*24*aa)))
                        let day7 = Date(timeIntervalSinceNow: -Double((60*60*24*gg)))
                                
                        let time1 = "\(formatterJP.string(from: day1))"
                        let time2 = "\(formatterJP.string(from: day2))"
                        let time3 = "\(formatterJP.string(from: day3))"
                        let time4 = "\(formatterJP.string(from: day4))"
                        let time5 = "\(formatterJP.string(from: day5))"
                        let time6 = "\(formatterJP.string(from: day6))"
                        let time7 = "\(formatterJP.string(from: day7))"
                                
                        labels[0] = time1
                        labels[1] = time2
                        labels[2] = time3
                        labels[3] = time4
                        labels[4] = time5
                        labels[5] = time6
                        labels[6] = time7
                        let entries = self.datelist.enumerated().map { ChartDataEntry(x: Double($0.offset), y: Double($0.element)) }
                        let dataSet = LineChartDataSet(entries: entries)
                        let data = LineChartData(dataSet: dataSet)
                        self.chartsView.data = data
                        self.chartsView.xAxis.valueFormatter = IndexAxisValueFormatter(values:labels)
                        self.chartsView.xAxis.granularity = 1
                        self.chartsView.xAxis.labelCount = 7
                        self.chartsView.xAxis.labelPosition = .bottom
                        self.chartsView.xAxis.labelTextColor = .gray
                        self.chartsView.xAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 8.0)!
                        self.chartsView.xAxis.drawGridLinesEnabled = false
                        self.chartsView.xAxis.drawAxisLineEnabled = false
                        self.chartsView.leftAxis.axisMinimum = 0
                        self.chartsView.leftAxis.axisMaximum = 10
                        self.chartsView.leftAxis.drawZeroLineEnabled = false
                        self.chartsView.leftAxis.zeroLineColor = .gray
                        dataSet.drawValuesEnabled = false
                        dataSet.colors = [#colorLiteral(red: 0.27, green: 0.80, blue: 0.79, alpha: 1.0)]
                        self.chartsView.leftAxis.drawAxisLineEnabled = false
                        self.chartsView.rightAxis.enabled = false
                                //太さ
                                dataSet.lineWidth = 2.5
                                //凡例削除
                                self.chartsView.legend.enabled = false
                                //色の指定　数値の表示非表示
                                dataSet.drawValuesEnabled = false
                                //プロットの大きさ
                                dataSet.drawCirclesEnabled = true
                                dataSet.circleRadius = 2
                                dataSet.circleColors = [UIColor.lightGray]
                                //アニメーション　つけなくてもいいかも
                                self.chartsView.animate(xAxisDuration: 1)
                                // タップでプロットを選択できないようにする
                                self.chartsView.highlightPerTapEnabled = false
                    
                }
                
            }
            
        }
    }
    
    

    @IBAction func share(_ sender: Any) {
        let image = takeScreenShot()
            let text = q
            let items = [text, image] as [Any]
            let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
            present(activityVC, animated: true)
        
    }
    
    func takeScreenShot() -> UIImage {
        let width: CGFloat = chartsView.bounds.size.width
        let height: CGFloat = chartsView.bounds.size.height
        let size = CGSize(width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        chartsView.drawHierarchy(in: chartsView.bounds, afterScreenUpdates: true)
        let screenShotImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return screenShotImage
    }
    


}

