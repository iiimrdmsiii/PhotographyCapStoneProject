//
//  BioViewController.swift
//  CapStone Project (Photographer)
//
//  Created by Dallin Smuin on 2/8/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class BioViewController: UIViewController {
    
    //*********************************************************
    // MARK: - Properties
    //*********************************************************
    
    var db: Firestore!
    
    var bio: Bio? {
        
        didSet {
            guard let bio = bio else { return }
            
            //if isCustomer is true then hide the buttons so the view works for customers
            //if isCustomer is false then dont do anything, the view was already designed for photographers
//            updateView(with: bio.isCustomer)
//            bio.isCustomer
            updateView(with: bio)
        }
    }
    
    //*********************************************************
    // MARK: - Outlets
    //*********************************************************
    @IBOutlet weak var chooseImageButton: UIButton!
    @IBOutlet weak var bioImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var currentStateTextField: UITextField!
    @IBOutlet weak var socialMediaTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var editButton: UIButton!
    
    //*********************************************************
    // MARK: - Actions
    //*********************************************************
    
    @IBAction func saveBarButtonTapped(_ sender: UIBarButtonItem) {
        
        let name = nameTextField.text ?? ""
        let number = phoneNumberTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let currentState = currentStateTextField.text ?? ""
        let socialMedia = socialMediaTextField.text ?? ""
        let website = websiteTextField.text ?? ""
        let about = aboutTextView.text ?? ""
        
        
        bio = Bio(name: name, number: number , email: email, currentState: currentState, instagram: socialMedia, webSite: website, aboutYou: about, password: "")
        
    }

    
    func updateView(with bio: Bio) {
        nameTextField.text = bio.name
        emailTextField.text = bio.email
        phoneNumberTextField.text = bio.number
        emailTextField.text = bio.email
        currentStateTextField.text = bio.currentState
        socialMediaTextField.text = bio.instagram
        websiteTextField.text = bio.webSite
        aboutTextView.text = bio.aboutYou
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            
        } catch let signOutError as NSError {
            print("There's a problem loggiog out, \(signOutError)")
        }
        
    }
    //*********************************************************
    // MARK: - Override Methods
    //*********************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readArray()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let photographerIndex = BioController.shareController.photographerThatJustRegistered {
            let bio = BioController.shareController.bios[photographerIndex]
            updateView(with: bio)
        }
    }
    

    
    //*********************************************************
    // MARK: - Database Cloud Firestore
    //*********************************************************
    
    // Retrieve data from the firestore
    func readArray() {
        
        self.db.collection("users").getDocuments { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in snapshot!.documents {
                    
                    let name = document.get("name") as! String
                    let email = document.get("email") as! String
                    let currentState = document.get("currentState") as! String
                    let phoneNumber = document.get("phoneNumber") as! String
                    let socialMedia = document.get("socialMedia") as! String
                    let website = document.get("website") as! String
                    let aboutYou = document.get("aboutYou") as! String
                    print(name, email, currentState, phoneNumber, socialMedia, website, aboutYou)
                    
                }
            }
        }
    }
    

    // Add a new document in collection "Profile"
    
    

    
    
}
