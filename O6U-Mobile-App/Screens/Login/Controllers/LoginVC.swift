//
//  LoginVC.swift
//  O6U-Mobile-App
//
//  Created by Mohamed Ahmed on 12/26/19.
//  Copyright © 2019 Ahmed Ramzy. All rights reserved.
//

import UIKit
import GSMessages
import SKActivityIndicatorView

class LoginVC: UIViewController {
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if Helper.checkConnection() == true {
            guard let username = usernameTextField.text , !username.isEmpty else {return}
            guard let password = passwordTextField.text , !password.isEmpty else {return}
            SKActivityIndicator.show()
            NetworkClient.performRequest(loginResponseModel.self, router: APIRouter.login(username: username, password: password), success: {[weak self] (model) in
                SKActivityIndicator.dismiss()
                if let token = model.data?.Authorization {
                    DataManager.setToken(Token: token)
                    DataManager.setIsLoggedIn(isLoggedIn: true)
                    AuthManager.loggedIn = true
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                    self?.present(homeVC, animated: true, completion: nil)
                } else {
                    self?.showMessage("Wrong username or password", type: .error)
                }
            }) { (error) in
                print(error)
            }
        } else {
            Helper.showInternetConnectionError(viewController: self)
        }
        
        
        
        
        
    }
    
}
