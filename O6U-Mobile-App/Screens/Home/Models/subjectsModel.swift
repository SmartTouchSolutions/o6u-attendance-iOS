//
//  subjectsModel.swift
//  O6U-Mobile-App
//
//  Created by Mohamed Ahmed on 12/30/19.
//  Copyright © 2019 Ahmed Ramzy. All rights reserved.
//

import Foundation


struct subjectsResponseModel: Decodable {
    var success: Bool?
    var data: [subjectsDataModel]?
    var error: String?
}


struct subjectsDataModel: Decodable {
    var id: Int?
    var users_id: String?
    var subject_id: Int?
    var term: String?
    var created_at: String?
    var updated_at: String?
    var lectures_count: Int?
    var subjects: subjectsData?
}


struct subjectsData: Decodable {
    var id: Int?
    var name: String?
}
