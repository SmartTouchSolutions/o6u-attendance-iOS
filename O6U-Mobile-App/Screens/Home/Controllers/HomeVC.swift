//
//  HomeVC.swift
//  O6U-Mobile-App
//
//  Created by Mohamed Ahmed on 12/26/19.
//  Copyright © 2019 Ahmed Ramzy. All rights reserved.
//

import UIKit
import SKActivityIndicatorView

class HomeVC: UIViewController {
    @IBOutlet var welcomeView: UIView!
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var subjectsTableView: UITableView!
    
    private var subjectsArray:[subjectsDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeViewSetup()
        getDoctorSubject()
    }
    
    private func welcomeViewSetup() {
        welcomeView.clipsToBounds = true
        welcomeView.layer.cornerRadius = 25
        welcomeView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner , .layerMinXMinYCorner]
    }
    
    private func getDoctorSubject() {
        NetworkClient.performRequest(subjectsResponseModel.self, router: APIRouter.getDoctorSubjects, success: {[weak self] (model) in
            guard let subjectsList = model.data else {return}
            self?.subjectsArray = subjectsList
            DispatchQueue.main.async {
                self?.subjectsTableView.reloadData()
            }
        }) { (error) in
            print(error)
        }
    }
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        SKActivityIndicator.show()
        NetworkClient.performRequest(logoutResponseModel.self, router: APIRouter.logout, success: {[weak self] (model) in
            SKActivityIndicator.dismiss()
            print(model)
            DispatchQueue.main.async {
                if model.success == true {
                    DataManager.deleteToken()
                    DataManager.setIsLoggedIn(isLoggedIn: false)
                    AuthManager.loggedIn = false
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                    self?.present(loginVC, animated: true, completion: nil)
                }
            }
        }) { (error) in
            print(error)
        }
    }
    
    
}


extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubjectsCell", for: indexPath) as! SubjectsCell
        if indexPath.row % 2 == 0 {
            cell.containerView.backgroundColor = #colorLiteral(red: 0.1215686275, green: 0.5568627451, blue: 0.7529411765, alpha: 1)
        } else {
            cell.containerView.backgroundColor = #colorLiteral(red: 0.02476949617, green: 0.3134329021, blue: 0.5700649023, alpha: 1)
        }
        
        cell.nameLabel.text = subjectsArray[indexPath.row].subjects?.name
        cell.countLabel.text = "\(subjectsArray[indexPath.row].lectures_count ?? 0)"
        return cell
    }
}


extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subjectId = subjectsArray[indexPath.row].id
        let subject = subjectsArray[indexPath.row].subject_id
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let lecturesVC = storyboard.instantiateViewController(withIdentifier: "LecturesVC") as! LecturesVC
        lecturesVC.selectedSubjectID = subjectId
        lecturesVC.selectedSubject = subject
        present(lecturesVC, animated: true, completion: nil)
    }
}
