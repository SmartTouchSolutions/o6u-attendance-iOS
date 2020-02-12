//
//  LoginModel.swift
//  O6U-Mobile-App
//
//  Created by Mohamed Ahmed on 12/30/19.
//  Copyright © 2019 Ahmed Ramzy. All rights reserved.
//

import Foundation

struct loginResponseModel: Decodable {
    var success: Bool?
    var data: loginResponseData?
    var error: String?
}

struct loginResponseData: Decodable {
    var id: Int?
    var name: String?
    var username: String?
    var email: String?
    var type: String?
    var Authorization: String?
}

struct logoutResponseModel: Decodable {
    var success: Bool?
    var data: String?
    var error: String?
}
