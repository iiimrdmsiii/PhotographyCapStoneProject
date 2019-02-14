//
//  PhotographySignInViewController.swift
//  CapStone Project (Photographer)
//
//  Created by Dallin Smuin on 2/7/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import UIKit

class PhotographySignInViewController: UIViewController {
    
    //*********************************************************
    // MARK: - Properties
    //*********************************************************
    
    
    
    //*********************************************************
    // MARK: - Outlets
    //*********************************************************
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var dontHaveAnAccountButton: UIButton!
    
    //*********************************************************
    // MARK: - Actions
    //*********************************************************
    
    // If nothing in TextField, it wont move to next screen and give an alert else has TextField Will move to next screen.
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        if userNameTextField.text?.isEmpty ?? false || passwordTextField.text?.isEmpty ?? false {
            
            let alert = UIAlertController(title: "Login Alert", message: "Please put in Email or Passward.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            print("sorry it didnt login")
        } else {
            performSegue(withIdentifier: "LoginSegue", sender: self)
            
            print("It worked!!!")
        }
    }
    
    //*********************************************************
    // MARK: - Override Methods
    //*********************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //*********************************************************
    // MARK: - Methods
    //*********************************************************
    
    // Unwind segue from the logout button for the Photographers
    @IBAction func unwindToLoginScreen(for unwindSegue: UIStoryboardSegue) {
    }
    

}






//*********************************************************
// MARK: - Others
//*********************************************************


// Login Action
//if (loginButton.titleLabel?.text == "Logout") {
//    let preferences = UserDefaults.standard
//    preferences.removeObject(forKey: "session")
//
//    LoginToDo()
//    return
//}
//
//let username = userNameTextField.text
//let password = passwordTextField.text
//
//if (username == "" || password == "") {
//    return
//}
//DoLogin(username!, password!)


// Override
//let preferences = UserDefaults.standard
//
//if (preferences.object(forKey: "session") != nil) {
//    LoginDone()
//} else {
//    LoginToDo()
//}

//func DoLogin(_ user: String, _ psw: String) {
//
//    let url = URL(string: "http://www.kaleidosblog.com/tutorial/login/api/Login")
//    let session = URLSession.shared
//
//    let request = NSMutableURLRequest(url: url!)
//    request.httpMethod = "Post"
//
//    let paramToSend = "username=" + user + "&password=" + psw
//
//    request.httpBody = paramToSend.data(using: String.Encoding.utf8)
//
//    let task = session.dataTask(with: request as URLRequest, completionHandler: {
//        (data, response, error) in
//
//        guard let _:Data = data else {
//            return
//        }
//
//        let json: Any?
//
//        do {
//            json = try JSONSerialization.jsonObject(with: data!, options: [])
//        } catch {
//            return
//        }
//
//        guard let serverResponse = json as? NSDictionary else {
//            return
//        }
//
//        if let dataBlock = serverResponse["data"] as? NSDictionary {
//            if let sessionData = dataBlock ["session"] as? String {
//                let perferences = UserDefaults.standard
//                perferences.set(sessionData, forKey: "session")
//
//                DispatchQueue.main.async (
//                    execute: self.LoginDone
//                )
//            }
//        }
//    })
//    task.resume()
//}
//
//func LoginToDo() {
//
//    userNameTextField.isEnabled = true
//    passwordTextField.isEnabled = true
//
//    loginButton.setTitle("Login", for: .normal)
//}
//
//func LoginDone() {
//    userNameTextField.isEnabled = false
//    passwordTextField.isEnabled = false
//
//
//
//    loginButton.setTitle("Logout", for: .normal)
//}
