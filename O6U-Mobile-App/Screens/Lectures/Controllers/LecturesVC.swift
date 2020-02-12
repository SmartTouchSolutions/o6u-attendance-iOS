//
//  LecturesVC.swift
//  O6U-Mobile-App
//
//  Created by Mohamed Ahmed on 12/30/19.
//  Copyright © 2019 Ahmed Ramzy. All rights reserved.
//

import UIKit
import GSMessages
import SKActivityIndicatorView

class LecturesVC: UIViewController {
    @IBOutlet var lecturesTableView: UITableView!
    
   private var lecturesList:[lecturesDataModel] = []
   public var selectedSubjectID: Int?
   public var selectedSubject: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLectures()
    }
    
    
    private func getLectures() {
        SKActivityIndicator.show()
        NetworkClient.performRequest(lecturesResponseModel.self, router:APIRouter.getSubjectLectures(subject_user_id: selectedSubjectID!), success: {[weak self] (model) in
            SKActivityIndicator.dismiss()
            guard let lecutresArray = model.data else {return}
            self?.lecturesList = lecutresArray
            DispatchQueue.main.async {
                self?.lecturesTableView.reloadData()
            }
        }) { (error) in
            print(error)
        }
    }
    
    
    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addLecture(_ sender: UIButton) {
          SKActivityIndicator.show()
        NetworkClient.performRequest(addLectureModel.self, router: APIRouter.createLecture(subject_user_id:selectedSubjectID!), success: {[weak self] (model) in
            SKActivityIndicator.dismiss()
            if model.success == true {
                self?.showMessage("Lecture has been added", type: .success)
            } else {
                guard let errorMessage = model.error else {return}
                self?.showMessage(errorMessage, type: .error)
            }
        }) { (error) in
            print(error)
        }
    }
    
}


extension LecturesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lecturesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LecturesCell", for: indexPath) as! LecturesCell
        cell.lectureNumber.text = "Lecutre Number: \(indexPath.row)"
        cell.lectureDate.text = lecturesList[indexPath.row].created_at
        cell.studentsCount.text = "\(lecturesList[indexPath.row].count_all_students ?? 0)"
        
        return cell
    }
}

extension LecturesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSubjectId = selectedSubjectID
        let lecutreId = lecturesList[indexPath.row].id
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let attendanceVC = storyboard.instantiateViewController(withIdentifier: "AttendanceVC") as! AttendanceVC
        attendanceVC.selectedSubjectId = selectedSubjectId
        attendanceVC.subjectId = selectedSubject
        attendanceVC.lectureId = lecutreId
        self.present(attendanceVC, animated: true, completion: nil)
    }
}
