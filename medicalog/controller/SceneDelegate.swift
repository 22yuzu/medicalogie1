//
//  SceneDelegate.swift
//  medicalog
//
//  Created by 冨岡哲平 on 2022/07/28.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        var finished = false
        
        let user = Auth.auth().currentUser
            if let user = user{
            Firestore.firestore().collection("users").document(user.uid).getDocument{(snap, error) in if let error = error {
                    print("error")
                
                }
                guard let data = snap?.data() else { return }
                if data["familyid"] != nil{
                    print("a")
                    let window = UIWindow(windowScene: scene as! UIWindowScene)
                    self.window = window
                    window.makeKeyAndVisible()
                    let storyboad = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyboad.instantiateViewController(identifier: "tabVC") as! tabbarController
                    let navigationVC = UINavigationController(rootViewController: viewController)
                    window.rootViewController = navigationVC
                    finished = true
                }else{
                    print("b")
                    let window = UIWindow(windowScene: scene as! UIWindowScene)
                    self.window = window
                    window.makeKeyAndVisible()
                    let storyboad = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyboad.instantiateViewController(identifier: "showOrVC") as! ShowOrViewController
                    let navigationVC = UINavigationController(rootViewController: viewController)
                    window.rootViewController = navigationVC
                }
                
                
                }

            }else{
                print("c")
                let window = UIWindow(windowScene: scene as! UIWindowScene)
                self.window = window
                window.makeKeyAndVisible()
                let storyboad = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboad.instantiateViewController(identifier: "signupVC")
                let navigationVC = UINavigationController(rootViewController: viewController)
                window.rootViewController = navigationVC
                
            }
        
        //ログイン状態とそうでない時で分ける
    /*    if Auth.auth().currentUser?.uid != nil{
            //ログイン状態ではHomeviewController
            let window = UIWindow(windowScene: scene as! UIWindowScene)
            self.window = window
            window.makeKeyAndVisible()
            let storyboad = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboad.instantiateViewController(identifier: "tabVC") as! tabbarController
            let navigationVC = UINavigationController(rootViewController: viewController)
            window.rootViewController = navigationVC
        }else{
            //ログインしてない時
            let window = UIWindow(windowScene: scene as! UIWindowScene)
            self.window = window
            window.makeKeyAndVisible()
            let storyboad = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboad.instantiateViewController(identifier: "signupVC")
            let navigationVC = UINavigationController(rootViewController: viewController)
            window.rootViewController = navigationVC
        }
    
        
        */
        
        
        
        
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

