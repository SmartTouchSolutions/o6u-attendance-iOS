//
//  AttendanceModel.swift
//  O6U-Mobile-App
//
//  Created by Mohamed Ahmed on 12/31/19.
//  Copyright © 2019 Ahmed Ramzy. All rights reserved.
//

import Foundation

struct attendanceResponseModel: Decodable {
    var success: Bool?
    var data: attendanceDataModel?
}

struct attendanceDataModel: Decodable {
    var count_all_lectures_of_subject: Int?
    var attendance: [attendanceData]?
    var studentsWithNoAttendance: [absentData]?
}

struct attendanceData: Decodable {
    var student_id: Int?
    var count_all_lectures: Int?
    var student_attendance: studentData?
}


struct studentData: Decodable {
    var id: Int?
    var username: String?
}

struct absentData: Decodable {
    var id: Int?
    var username: String?
}


struct addScan: Decodable {
    var success: Bool?
    var data:String?
    var error: String?
}
