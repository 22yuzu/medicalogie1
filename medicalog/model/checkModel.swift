//
//  checkModel.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/08/12.
//

import Photos
import Foundation
class checkModel {
    func showCheck(){
        PHPhotoLibrary.requestAuthorization { (status) in
            
            switch(status) {
            case .authorized:
                print("許可")
            case .denied:
                print("拒否")
            case .notDetermined:
                print("notDetermin")
            case .restricted:
                print("restricted")
            case .limited:
                print("limited")
            @unknown default: break
                
            }
            
        }
    }
}
