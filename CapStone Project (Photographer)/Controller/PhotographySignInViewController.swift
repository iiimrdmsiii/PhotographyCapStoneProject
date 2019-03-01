//
//  PhotographySignInViewController.swift
//  CapStone Project (Photographer)
//
//  Created by Dallin Smuin on 2/7/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class PhotographySignInViewController: UIViewController {
    
    //*********************************************************
    // MARK: - Properties
    //*********************************************************
    
    var isSignIn: Bool = true
    
    
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
        
//        if let email = userNameTextField.text, let password = passwordTextField.text {
//            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
//                if let firebaseError = error {
//                    print(firebaseError.localizedDescription)
//                    return
//                }
//                print("logged in worked")
//            }
//        }
        
        if userNameTextField.text?.isEmpty ?? false || passwordTextField.text?.isEmpty ?? false {
            
            let alert = UIAlertController(title: "Login Alert", message: "Please put in Email or Passward.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            print("You need to sign in first or enter email and password.")
        } else {
//            performSegue(withIdentifier: "bioFromLoginSegue", sender: self)
            
            
            
            print("It worked!!!")
        }
    }
    
//    func presentLoggedInScreen() {
//
//        let stroyborad: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let photographySignIn: PhotographySignInViewController = stroyborad.instantiateInitialViewController(withIdentifier: "bioFromLoginSegue")
//        self.present(PhotographySignInViewController, animated: true, completion: nil)
//    }
    
    //*********************************************************
    // MARK: - Override Methods
    //*********************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loginButton.layer.cornerRadius = 15
        self.dontHaveAnAccountButton.layer.cornerRadius = 10
        
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    //*********************************************************
    // MARK: - Methods
    //*********************************************************
    
    // Unwind segue from the logout button for the Photographers
    @IBAction func unwindToLoginScreen(for unwindSegue: UIStoryboardSegue) {
        
        userNameTextField.text = ""
        passwordTextField.text = ""
    }
    
    // handle the login for username and password to be able to get to the bio
    @objc func handleLogin() {
        
        guard let email = userNameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil && user != nil {
                self.performSegue(withIdentifier: "bioFromLoginSegue", sender: self)
            } else {
                print("Error Logging in: \(error!.localizedDescription)")
                
                self.resetForm()
            }
        }
    }
    
    func resetForm() {
        
        let alert = UIAlertController(title: "Check your Email or Password", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
}









//*********************************************************
// MARK: - Others
//*********************************************************


//        override func viewDidAppear(_ animated: Bool) {
//            super.viewDidAppear(animated)
//
//            if let user = Auth.auth().currentUser {
//                self.performSegue(withIdentifier: "bioFromLoginSegue", sender: self)
//            }
//        }


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
