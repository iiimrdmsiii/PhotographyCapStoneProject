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

        if userNameTextField.text?.isEmpty ?? false || passwordTextField.text?.isEmpty ?? false {
            
            let alert = UIAlertController(title: "Login Alert", message: "Please put in Email or Passward.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            print("You need to sign in first or enter email and password.")
        } else {
            
            print("It worked!!!")
        }
    }
    
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
        
        let alert = UIAlertController(title: "Double Check", message: "Check your Email or Password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
}
