//
//  AuthenticationManager.swift
//  O6U-Mobile-App
//
//  Created by Mohamed Ahmed on 12/30/19.
//  Copyright © 2019 Ahmed Ramzy. All rights reserved.
//

import Foundation


class AuthManager {
    static var loggedIn = DataManager.getIsLoggedIn()!
    
    static func authKey() -> String {
        var fullToken = ""
        if let token = DataManager.getToken() {
            fullToken = token
        }
        return fullToken
    }
}
