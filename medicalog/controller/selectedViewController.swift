//
//  selectedViewController.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/08/28.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Charts
import SDWebImage

class selectedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var todayDay: UILabel!
    @IBOutlet weak var points: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var date1 = ""
    let user = Auth.auth().currentUser
    var cellCount = 0
    var no1 = ""
    var no2 = ""
    var no3 = ""
    var no4 = ""
    var no5 = ""
    var no6 = ""
    var no7 = ""
    var no8 = ""
    var no9 = ""
    var no10 = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        todayDay.text = date1
        
        print(date1)
        
        
        if let user = user {
            Firestore.firestore().collection("users").document(user.uid).getDocument{(snap, error) in if let error = error {
                print("a")
                
            }
            guard let data = snap?.data() else { return }
            let familyid = data["familyid"]  as! String
                print("familyidは" + familyid)
                Firestore.firestore().collection(familyid).document(self.date1).getDocument{(snap, error) in if let error = error {
                    
                    //選択された日がなかった時
                    print("エラー")
                    return
                }
                    guard let a = snap?.data() else {
                        
                        //選択された日がなかった時
                        print("エラー2")
                        return
                    }
                    if a["nikinumber"] != nil{
                        //日記が書かれていた時
                        self.cellCount = a["nikinumber"] as! Int
                        self.tableView.reloadData()
                    }
                    Firestore.firestore().collection(familyid).document("taityouSetting").getDocument { (snap, error) in if let error = error {
                        print("エラー")
                    }
                        guard let b = snap?.data() else {return}
                            self.no1 = b["1"] as! String
                            self.no2 = b["2"] as! String
                            self.no3 = b["3"] as! String
                            self.no4 = b["4"] as! String
                            self.no5 = b["5"] as! String
                            self.no6 = b["6"] as! String
                            self.no7 = b["7"] as! String
                            self.no8 = b["8"] as! String
                            self.no9 = b["9"] as! String
                            self.no10 = b["10"] as! String
                        var bennpi = 0
                        var geri = 0
                        var darusa = 0
                        var hakike = 0
                        var hatunetu = 0
                        var itami = 0
                        var sibire = 0
                        var suimin = 0
                        var syokuyoku = 0
                        var iki = 0
                        if a[self.no1] != nil {
                            bennpi = a[self.no1] as! Int
                        }else{
                            bennpi = 0
                        }
                        if a[self.no2] != nil {
                            geri = a[self.no2] as! Int
                        }else{
                            geri = 0
                        }
                        if a[self.no3] != nil {
                            darusa = a[self.no3] as! Int
                        }else{
                            darusa = 0
                        }
                        if a[self.no4] != nil {
                            hakike = a[self.no4] as! Int
                        }else{
                            hakike = 0
                        }
                        if a[self.no5] != nil {
                            hatunetu = a[self.no5] as! Int
                        }else{
                            hatunetu = 0
                        }
                        if a[self.no6] != nil {
                            itami = a[self.no6] as! Int
                        }else{
                            itami = 0
                        }
                        if a[self.no7] != nil {
                            sibire = a[self.no7] as! Int
                        }else{
                            sibire = 0
                        }
                        if a[self.no8] != nil {
                            suimin = a[self.no8] as! Int
                        }else{
                            suimin = 0
                        }
                        if a[self.no9] != nil {
                            syokuyoku = a[self.no9] as! Int
                        }else{
                            syokuyoku = 0
                        }
                        if a[self.no10] != nil {
                            iki = a[self.no10] as! Int
                        }else{
                            iki = 0
                        }
                        
                            var labels:[String] = [self.no1,self.no2,self.no3,self.no4,self.no5,self.no6,self.no7,self.no8,self.no9,self.no10]
                            let rawdata:[Int] = [bennpi, geri, darusa, hakike, hatunetu, itami, sibire, suimin, syokuyoku, iki]
                            let entries = rawdata.enumerated().map { BarChartDataEntry(x: Double($0.offset), y: Double($0.element)) }
                            let dataSet = BarChartDataSet(entries: entries)
                            let data = BarChartData(dataSet: dataSet)
                            self.barChartView.data = data
                            self.barChartView.xAxis.labelCount = 10
                            // X軸のラベルの位置を下に設定
                            self.barChartView.xAxis.labelPosition = .bottom
                            // X軸のラベルの色を設定
                            self.barChartView.xAxis.labelTextColor = .systemGray
                            self.barChartView.xAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 7.0)!
                            // X軸の線、グリッドを非表示にする
                            self.barChartView.xAxis.drawGridLinesEnabled = false
                            self.barChartView.xAxis.drawAxisLineEnabled = false
                            self.barChartView.rightAxis.enabled = false
                            // Y座標の値が0始まりになるように設定
                            self.barChartView.leftAxis.axisMinimum = 0
                            self.barChartView.leftAxis.axisMaximum = 10
                            self.barChartView.leftAxis.drawZeroLineEnabled = true
                            self.barChartView.leftAxis.zeroLineColor = .systemGray
                            self.barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:labels)
                            self.barChartView
                                .xAxis.granularity = 1
                            // ラベルの数を設定
                            self.barChartView.leftAxis.labelCount = 10
                            // ラベルの色を設定
                            self.barChartView.leftAxis.labelTextColor = .systemGray
                            // グリッドの色を設定
                            self.barChartView.leftAxis.gridColor = .systemGray
                            // 軸線は非表示にする
                            self.barChartView.leftAxis.drawAxisLineEnabled = false
                            self.barChartView.legend.enabled = false
                            dataSet.drawValuesEnabled = false
                            dataSet.colors = [.systemBlue]
                            self.barChartView.doubleTapToZoomEnabled = false
                            self.barChartView.animate(xAxisDuration: 2.5, yAxisDuration: 2.5, easingOption: .linear)
                        dataSet.colors = [#colorLiteral(red: 0.27, green: 0.80, blue: 0.79, alpha: 1.0)]
                        
                        if a[self.no1] != nil && a[self.no2] != nil && a[self.no3] != nil && a[self.no4] != nil && a[self.no5] != nil && a[self.no6] != nil && a[self.no7] != nil && a[self.no8] != nil && a[self.no9] != nil && a[self.no10] != nil{
                            let bennpi = a[self.no1] as! Int
                            let geri = a[self.no2] as! Int
                            let darusa = a[self.no3] as! Int
                            let hakike = a[self.no4] as! Int
                            let hatunetu = a[self.no5] as! Int
                            let itami = a[self.no6] as! Int
                            let sibire = a[self.no7] as! Int
                            let suimin = a[self.no8] as! Int
                            let syokuyoku = a[self.no9] as! Int
                            let iki = a[self.no10] as! Int
                            self.points.text = String(100 - bennpi - geri - darusa - hakike - hatunetu - itami - sibire - suimin - syokuyoku - iki)}
                        
                        
    
                    
                        
                             
                        //var labels:[String] = [self.no1,self.no2,self.no3,self.no4,self.no5,self.no6,self.no7,self.no8,self.no9,self.no10]

                    
                  /*  let bennpi = a["bennpi"] as! Int
                    let geri = a["geri"] as! Int
                    let darusa = a["darusa"] as! Int
                    let hakike = a["hakike"] as! Int
                    let hatunetu = a["hatunetu"] as! Int
                    let itami = a["itami"] as! Int
                    let sibire = a["sibire"] as! Int
                    let suimin = a["suimin"] as! Int
                    let syokuyoku = a["syokuyoku"] as! Int
                    let iki = a["iki"] as! Int
                    
                    self.points.text = String(100 - bennpi - geri - darusa - hakike - hatunetu - itami - sibire - suimin - syokuyoku - iki)
                    */
                    }
                }
                
            }
        }

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return cellCount
        }
    
    var place = 0
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        if let user = user {
            Firestore.firestore().collection("users").document(user.uid).getDocument{(snap, error) in if let error = error {
                print("a")
                
            }
            guard let data = snap?.data() else { return }
            let familyid = data["familyid"]  as! String
                
                Firestore.firestore().collection(familyid).document(self.date1).getDocument { [self] (document, error) in if let document = document, document.exists{
                    //選択された日があったとき
                    //日記が書かれてなかった時のことは考えなくていい？はず(エラー出るかも)
                    let alldata = document.data() ?? [:]
            
                    if alldata["nikinumber"] as! Int != nil{
                        place += 1
                        var nikidata = alldata[String(place)] as! [String : Any]
                        var body = nikidata["body"] as! String
                        var kimoti = nikidata["kimoti"] as! Int
                        print(kimoti)
                        var name = nikidata["name"] as! String
                        var useruid = nikidata["useruid"] as! String
                        print(useruid)
                        Firestore.firestore().collection("users").document(useruid).getDocument { (snap,error) in if let error = error{
                            print("エラーa")
                        }
                            guard let imagedata = snap?.data() else {
                                print("エラーb")
                                return }
                            if imagedata["userprofileimage"] != nil{
                                print(useruid)
                                print(imagedata["userprofileimage"])
                                let imageString = data["userprofileimage"] as! String
                                cell.profileimage.sd_setImage(with: URL(string: imageString), completed: nil)
                            }else{
                                cell.profileimage.backgroundColor = UIColor(red: 0.13, green: 0.70, blue: 0.67, alpha: 1.0)
                            }
                        }
                        cell.content.text = body
                        cell.content.isEditable = false
                        cell.shadowlayer.layer.shadowOpacity = Float(kimoti)*0.1
                        cell.shadowlayer.layer.shadowRadius = CGFloat(Float(kimoti)*1.5)
                        cell.username.text = name
                        
                    }
                    
                    
                        
                        
                    
                    }
                    
                }
                    //選択された日がなかった時
                    //セルの数をゼロにするから考えなくていい？はず
                    
                }
                
            }

            cell.mainBackground.layer.cornerRadius = 15
            cell.mainBackground.layer.masksToBounds = true
            //cell.backgroundColor = .systemGray6

            return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 260
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
