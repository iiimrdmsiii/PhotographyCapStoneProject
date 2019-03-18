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
import FirebaseStorage
import FirebaseDatabase

class BioViewController: UIViewController {
    
    //*********************************************************
    // MARK: - Properties
    //*********************************************************
    
    // this is the bucket that can contain water.
    var userType: UserType?
    
    // TextFilds
    var db: Firestore = Firestore.firestore()
    let userRef = Firestore.firestore().collection("users")
    
    var localBio: String = ""
    var localBioName: String = ""
    var localBioEmail: String = ""
    var localBioPhoneNumber: String = ""
    var localBioCurrentState: String = ""
    var localBioSocialMedia: String = ""
    var localBioWebsite: String = ""
    var localBioAboutYou: String = ""
    
    var userImage: UIImage? = UIImage()
    
    // retive image from firebase storage.
    let myImageView = UIImageView()
    let ref = Database.database().reference()
    let uid = Auth.auth().currentUser?.uid
    let imageRef = Database.database().reference().child("user")
    
    var bio: Bio? {
        
        didSet {
            guard let bio = bio else { return }
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
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //*********************************************************
    // MARK: - Actions
    //*********************************************************
    
    @IBAction func saveBarButtonTapped(_ sender: UIBarButtonItem) {
        
        
        if userType == UserType.photographer {
            let name = nameTextField.text ?? ""
            let number = phoneNumberTextField.text ?? ""
            let email = emailTextField.text ?? ""
            let currentState = currentStateTextField.text ?? ""
            let socialMedia = socialMediaTextField.text ?? ""
            let website = websiteTextField.text ?? ""
            let about = aboutTextView.text ?? ""
            
            bio = Bio(name: name, number: number , email: email, currentState: currentState, instagram: socialMedia, webSite: website, aboutYou: about, password: "")
            
            let alert = UIAlertController(title: "Updated", message: "You've updated your bio.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
        } else if userType == UserType.customer {
            self.navigationController?.popViewController(animated: true)
        }
    }

    func updateView(with bio: Bio) {
        bioImageView.image = userImage
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
    }
    //*********************************************************
    // MARK: - Override Methods
    //*********************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userType == UserType.customer {
            nameTextField.isUserInteractionEnabled = false
            phoneNumberTextField.isUserInteractionEnabled = false
            emailTextField.isUserInteractionEnabled = false
            currentStateTextField.isUserInteractionEnabled = false
            socialMediaTextField.isUserInteractionEnabled = false
            websiteTextField.isUserInteractionEnabled = false
            aboutTextView.isUserInteractionEnabled = false
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backBarItem))
        }
        
//        if localBioName != "" {
//
//            print("not nil!")
//
//            bioImageView.image = userImage
//
//            nameTextField.text = localBioName
//            phoneNumberTextField.text = localBioPhoneNumber
//            emailTextField.text = localBioEmail
//            currentStateTextField.text = localBioCurrentState
//            socialMediaTextField.text = localBioSocialMedia
//            websiteTextField.text = localBioWebsite
//            aboutTextView.text = localBioAboutYou
//        } else {
//            print("is nil :(")
//            print(localBio)
//        }
        
        
        
        updateUIWithCurrentUserData()
    }
    
    @objc func backBarItem() {
        self.navigationController?.popViewController(animated: true)
  
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
    
    // completion handler to get the image data form your url
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    // download the image
    func updateProfileImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.bioImageView.image = UIImage(data: data)
            }
        }
    }
    
    // Retrieve data from the firestore and upload onto the iphone screen
    func updateUIWithCurrentUserData() {

        
        // Queries FireStore to get ALL of the users
        self.db.collection("users").getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            // Loops through each user to find one document for each user
            for document in documents {
                // Access to the user
                
                self.bioImageView.image = self.userImage
                document.get("name")
                document.get("email")
                document.get("phoneNumber")
                document.get("currentState")
                document.get("website")
                document.get("aboutYou")
                document.get("socialMedia")
                
                
            }
        }
    }
}

