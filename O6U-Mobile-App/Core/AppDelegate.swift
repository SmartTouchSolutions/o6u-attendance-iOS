//
//  AppDelegate.swift
//  O6U-Mobile-App
//
//  Created by Mohamed Ahmed on 12/26/19.
//  Copyright © 2019 Ahmed Ramzy. All rights reserved.
//

import UIKit
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // disabling dark mode
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        IQKeyboardManager.shared().isEnabled = true
        handleSession()
        return true
    
}
    
    func handleSession() {
        if (DataManager.getToken() == nil) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC")
            self.window?.rootViewController = loginVC
        } else {
              let storyboard = UIStoryboard(name: "Main", bundle: nil)
             let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC")
             self.window?.rootViewController = homeVC
        }
    }

}
