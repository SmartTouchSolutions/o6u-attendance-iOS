//
//  AttendanceVC.swift
//  O6U-Mobile-App
//
//  Created by Mohamed Ahmed on 12/30/19.
//  Copyright © 2019 Ahmed Ramzy. All rights reserved.
//

import UIKit
import BarcodeScanner
import GSMessages
import SKActivityIndicatorView

class AttendanceVC: UIViewController {
    
    @IBOutlet var attendanceTableView: UITableView!
    private var attendanceArray:[attendanceData] = []
    private var abbsentArray:[absentData] = []
    public var selectedSubjectId: Int?
    public var subjectId:Int?
    public var lectureId: Int?
    private var totalLecturesCount: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAttendance()

    }
    
    
    private func getAttendance() {
        if Helper.checkConnection() == true {
            SKActivityIndicator.show()
            NetworkClient.performRequest(attendanceResponseModel.self, router: APIRouter.getAttendance(subject_user_id: selectedSubjectId!), success: { [weak self] (model) in
                SKActivityIndicator.dismiss()
                guard let attendanceList = model.data?.attendance else {return}
                guard let abssentList = model.data?.studentsWithNoAttendance else {return}
                guard let totalLecturesCount = model.data?.count_all_lectures_of_subject else {return}
                self?.totalLecturesCount = totalLecturesCount
                self?.attendanceArray = attendanceList
                self?.abbsentArray = abssentList
                DispatchQueue.main.async {
                    self?.attendanceTableView.reloadData()
                }
                
            }) { (error) in
                print(error)
            }
        } else {
            Helper.showInternetConnectionError(viewController: self)
        }
    }
    
    
    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func scanPressed(_ sender: UIButton) {
        let scannerVC = BarcodeScannerViewController()
        scannerVC.codeDelegate = self
        scannerVC.errorDelegate = self
        scannerVC.dismissalDelegate = self
        
        present(scannerVC, animated: true, completion: nil)
    }
    
}


extension AttendanceVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attendanceArray.count + abbsentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttendanceCell", for: indexPath) as! AttendanceCell
        
        if indexPath.row < attendanceArray.count {
            cell.nameLabel.text = attendanceArray[indexPath.row].student_attendance?.username
            cell.attendCount.text = "\(attendanceArray[indexPath.row].count_all_lectures ?? 0)"
            cell.absentCount.text = " \(totalLecturesCount! - attendanceArray[indexPath.row].count_all_lectures!) "
        } else {
            cell.nameLabel.text = abbsentArray[indexPath.row - attendanceArray.count].username
            cell.attendCount.text = "0"
            cell.absentCount.text = "\(self.totalLecturesCount!)"
        }
        return cell
    }
}

extension AttendanceVC: BarcodeScannerCodeDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print(code)
        NetworkClient.performRequest(addScan.self, router: APIRouter.addAttendance(subject_user_id: selectedSubjectId!, studentCode: code, lecture_id: lectureId!), success: {[weak self](model) in
            if model.success == true {
                self?.showMessage("Added Successfuly", type: .success)
                DispatchQueue.main.async {
                    self?.getAttendance()
                }
            } else {
                guard let error = model.error else {return}
                self?.showMessage(error, type: .error)
            }
        }) { (error) in
            print(error)
        }
        controller.dismiss(animated: true, completion: nil)
    }
}


extension AttendanceVC: BarcodeScannerErrorDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print(error)
    }
}

extension AttendanceVC: BarcodeScannerDismissalDelegate {
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
