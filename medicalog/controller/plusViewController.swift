//
//  plusViewController.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/08/28.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class plusViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var datePicker = UIDatePicker()
    @IBOutlet weak var taityou: UIButton!
    var chosenday = "今日"
    var datelist = ["今日", "きのう", "おととい"]
    @IBOutlet weak var picker: UIPickerView!
    let user = Auth.auth().currentUser
    

    
    @IBOutlet weak var darusa: UISlider!
    @IBOutlet weak var itami: UISlider!
    @IBOutlet weak var hakike: UISlider!
    @IBOutlet weak var syokuyoku: UISlider!
    @IBOutlet weak var iki: UISlider!
    @IBOutlet weak var hatunetu: UISlider!
    @IBOutlet weak var suimin: UISlider!
    @IBOutlet weak var sibire: UISlider!
    @IBOutlet weak var geri: UISlider!
    @IBOutlet weak var bennpi: UISlider!
    
    @IBOutlet weak var darusaLabel: UILabel!
    @IBOutlet weak var itamiLabel: UILabel!
    @IBOutlet weak var hakikeLabel: UILabel!
    @IBOutlet weak var syokuyokuLabel: UILabel!
    @IBOutlet weak var ikiLabel: UILabel!
    @IBOutlet weak var hatunetuLabel: UILabel!
    @IBOutlet weak var suiminLabel: UILabel!
    @IBOutlet weak var sibireLabel: UILabel!
    @IBOutlet weak var seisinLabel: UILabel!
    @IBOutlet weak var geriLabel: UILabel!
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
        picker.delegate = self
        picker.dataSource = self
        taityou.layer.cornerRadius = 10
        taityou.layer.shadowColor = UIColor.black.cgColor
        taityou.layer.shadowRadius = 4
        taityou.layer.shadowOffset = CGSize(width: 2, height: 2)
        taityou.layer.shadowOpacity = 0.3
        
        if let user = user {
            Firestore.firestore().collection("users").document(user.uid).getDocument{(snap, error) in if let error = error {
                    print("error")
                
                }
                guard let data = snap?.data() else { return }
                let familyid = data["familyid"]  as! String
                Firestore.firestore().collection(familyid).document("taityouSetting").getDocument{(snap, error) in if let error = error {
                        print("error")
                    
                    }
                    guard let taityoudata = snap?.data() else {
                        return }
                    print("ここまで来ました")
                    self.no1 = taityoudata["1"] as! String
                    self.no2 = taityoudata["2"] as! String
                    self.no3 = taityoudata["3"] as! String
                    self.no4 = taityoudata["4"] as! String
                    self.no5 = taityoudata["5"] as! String
                    self.no6 = taityoudata["6"] as! String
                    self.no7 = taityoudata["7"] as! String
                    self.no8 = taityoudata["8"] as! String
                    self.no9 = taityoudata["9"] as! String
                    self.no10 = taityoudata["10"] as! String
                    self.darusaLabel.text = self.no1
                    self.itamiLabel.text = self.no2
                    self.hakikeLabel.text = self.no3
                    self.syokuyokuLabel.text = self.no4
                    self.ikiLabel.text = self.no5
                    self.hatunetuLabel.text = self.no6
                    self.suiminLabel.text = self.no7
                    self.sibireLabel.text = self.no8
                    self.seisinLabel.text = self.no9
                    self.geriLabel.text = self.no10
                    
                    
                    
                    }
                
                }

        }

        
    }
    

    @IBAction func finished(_ sender: Any) {
        
        
        let darusaValue:Int = Int(darusa.value)
        let itamiValue:Int = Int(itami.value)
        let hakikeValue:Int = Int(hakike.value)
        let syokuyokuValue:Int = Int(syokuyoku.value)
        let ikiValue:Int = Int(iki.value)
        let hatunetuValue:Int = Int(hatunetu.value)
        let suiminValue:Int = Int(suimin.value)
        let sibireValue:Int = Int(sibire.value)
        let bennpiValue:Int = Int(bennpi.value)
        let geriValue:Int = Int(geri.value)
        
        let kyou = Date()
        let kinou = Date(timeIntervalSinceNow: -(60*60*24))
        let ototoi = Date(timeIntervalSinceNow: -(60*60*48))
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年 M月d日"
        let showkyou = formatter.string(from: kyou)
        let showkinou = formatter.string(from: kinou)
        let showototoi = formatter.string(from: ototoi)
        var selecteddate = showkyou
        if chosenday == "今日"{
            selecteddate = showkyou
        }
        if chosenday == "きのう"{
            selecteddate = showkinou
        }
        if chosenday == "おととい"{
            selecteddate = showototoi
        }
        print("選択された日は" + selecteddate)
        
        if let user = user {
            Firestore.firestore().collection("users").document(user.uid).getDocument{(snap, error) in if let error = error {
                print("a")
                
            }
            guard let data = snap?.data() else { return }
            let familyid = data["familyid"]  as! String
                print("familyidは" + familyid)
                Firestore.firestore().collection(familyid).document("taityouSetting").getDocument{(snap, error) in if let error = error {
                        print("error")
                    
                    }
                    guard let taityoudata = snap?.data() else {
                        return }
                    self.darusaLabel.text = taityoudata["1"] as! String
                    self.itamiLabel.text = taityoudata["2"] as! String
                    self.hakikeLabel.text = taityoudata["3"] as! String
                    self.syokuyokuLabel.text = taityoudata["4"] as! String
                    self.ikiLabel.text = taityoudata["5"] as! String
                    self.hatunetuLabel.text = taityoudata["6"] as! String
                    self.suiminLabel.text = taityoudata["7"] as! String
                    self.sibireLabel.text = taityoudata["8"] as! String
                    self.seisinLabel.text = taityoudata["9"] as! String
                    self.geriLabel.text = taityoudata["10"] as! String
                    
                    
                    }
                
                Firestore.firestore().collection(familyid).document(selecteddate).getDocument{(snap, error) in if let error = error {
                    Firestore.firestore().collection(familyid).document(selecteddate).setData([self.no1 : darusaValue, self.no2 : itamiValue, self.no3 : hakikeValue, self.no4 : syokuyokuValue, self.no5 : ikiValue, self.no6 : hatunetuValue, self.no7: suiminValue, self.no8 : sibireValue, self.no9 : bennpiValue, self.no10: geriValue])
                }
                    guard let c = snap?.data() else { return
                        Firestore.firestore().collection(familyid).document(selecteddate).setData([self.no1 : darusaValue, self.no2 : itamiValue, self.no3 : hakikeValue, self.no4 : syokuyokuValue, self.no5 : ikiValue, self.no6 : hatunetuValue, self.no7: suiminValue, self.no8 : sibireValue, self.no9 : bennpiValue, self.no10: geriValue])
                    }
                    let fire = Firestore.firestore().collection(familyid).document(selecteddate)
                    
                    fire.updateData([self.no1 : darusaValue])
                    fire.updateData([self.no2 : itamiValue])
                    fire.updateData([self.no3 : hakikeValue])
                    fire.updateData([self.no4 : syokuyokuValue])
                    fire.updateData([self.no5 : ikiValue])
                    fire.updateData([self.no6 : hatunetuValue])
                    fire.updateData([self.no7 : suiminValue])
                    fire.updateData([self.no8 : sibireValue])
                    fire.updateData([self.no9 : bennpiValue])
                    fire.updateData([self.no10: geriValue])
                    
                    
                }
                
            }
        }
        
        self.navigationController?.popViewController(animated: true)
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "tabVC") as! tabbarController
        self.navigationController?.pushViewController(nextViewController, animated: false)
        
        
        
        
    }
    
    
    func numberOfComponents(in picker: UIPickerView) -> Int {
            return 1
    }
    func pickerView(_ picker: UIPickerView,
                        numberOfRowsInComponent component: Int) -> Int {
            return datelist.count
    }
    func pickerView(_ picker: UIPickerView,
                       titleForRow row: Int,
                       forComponent component: Int) -> String? {
           
           return datelist[row]
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        if datelist[row] == "今日"{
            chosenday = "今日"
        }
        
        if datelist[row] == "きのう"{
            chosenday = "きのう"
        }
        
        if datelist[row] == "おととい"{
            chosenday = "おととい"
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

}
