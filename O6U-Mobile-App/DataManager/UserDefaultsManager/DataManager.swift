//
//  DataManager.swift
//  O6U-Mobile-App
//
//  Created by Mohamed Ahmed on 12/30/19.
//  Copyright © 2019 Ahmed Ramzy. All rights reserved.
//

import Foundation

class DataManager {
    
    class func setIsLoggedIn(isLoggedIn: Bool) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(isLoggedIn, forKey: "isLoggedIn")
    }
    
    class func getIsLoggedIn() -> Bool?
    {
        let userDefaults = UserDefaults.standard
        return userDefaults.object(forKey: "isLoggedIn") as? Bool
    }
    
    class func setToken(Token: String)
    {
        let userDefaults = UserDefaults.standard
        userDefaults.set(Token, forKey: "token")
    }
    
    class func getToken() -> String?
    {
        let userDefaults = UserDefaults.standard
        return userDefaults.object(forKey: "token") as? String
    }
    
    
    class  func deleteToken() -> Void
    {
        let userDefaults = UserDefaults.standard
        return  userDefaults.removeObject(forKey: "token")
    }
}


