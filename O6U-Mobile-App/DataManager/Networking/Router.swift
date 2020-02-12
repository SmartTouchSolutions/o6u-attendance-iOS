//
//  Router.swift
//  O6U-Mobile-App
//
//  Created by Mohamed Ahmed on 12/30/19.
//  Copyright © 2019 Ahmed Ramzy. All rights reserved.
//

import Foundation
import Alamofire


enum APIRouter: URLRequestConvertible {
    case login(username:String, password:String)
    case getDoctorSubjects
    case getSubjectLectures(subject_user_id:Int)
    case createLecture(subject_user_id:Int)
    case getAttendance(subject_user_id:Int)
    case addAttendance(subject_user_id:Int, studentCode:String,lecture_id:Int)
    case logout
    
    var method: HTTPMethod {
        switch self {
        case .login(_,_):
            return .post
        case .getDoctorSubjects:
            return .get
        case .getSubjectLectures(_):
            return .post
        case .createLecture(_):
            return .post
        case .getAttendance(_):
            return .post
        case .addAttendance(_,_,_):
            return .post
        case .logout:
            return .get

        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "login"
        case .getDoctorSubjects:
            return "get_doctor_subjects"
        case .getSubjectLectures:
            return "get_lecture"
        case .createLecture:
            return "create_lecture"
        case .getAttendance(_):
            return "get_attendance"
        case .addAttendance:
            return "create_attendance"
        case .logout:
            return "logout"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .login(let username, let password):
            return ["username":username,"password":password]
        case .getDoctorSubjects:
            return nil
        case .getSubjectLectures(let subject_user_id):
            return ["subject_user_id": subject_user_id]
        case .createLecture(let subject_user_id):
            return ["subject_user_id": subject_user_id]
        case .getAttendance(let subject_user_id):
            return ["subject_user_id": subject_user_id]
        case .addAttendance(let subject_user_id, let studentCode, let lecture_id):
            return ["subject_user_id":subject_user_id,"student_code":studentCode,"lecture_id":lecture_id]
        case .logout:
            return nil
        
        }
    }
    
    var AuthRequired: Bool {
        switch self {
        case .login:
            return false
        case .getDoctorSubjects:
            return true
        case .getSubjectLectures:
            return true
        case .createLecture:
            return true
        case .getAttendance:
            return true
        case .addAttendance:
                return true
        case .logout:
            return true
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseURL.asURL().appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if(AuthRequired){
            if(AuthManager.loggedIn) {
                request.setValue(AuthManager.authKey(), forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
            }
        }
        if let parameters = parameters {
            return try URLEncoding.default.encode(request, with: parameters)
        }
        return request
    }
    
}
