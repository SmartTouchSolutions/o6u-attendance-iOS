//
//  LecutreModel.swift
//  O6U-Mobile-App
//
//  Created by Mohamed Ahmed on 12/30/19.
//  Copyright © 2019 Ahmed Ramzy. All rights reserved.
//

import Foundation

struct lecturesResponseModel: Decodable {
    var success: Bool?
    var data: [lecturesDataModel]?
    var error: String?
}

struct lecturesDataModel: Decodable {
    var id: Int?
    var count_all_students: Int?
    var created_at: String?
}

struct addLectureModel: Decodable {
    var success: Bool?
    var data: String?
    var error: String?
}
