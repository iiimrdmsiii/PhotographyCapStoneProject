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
    
    var bioRetrive: Bio? {
        
        didSet {
            updateUIWithCurrentUserData()
        }
    }
        
    
    
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
    let imageRef = Database.database().reference().child("imageURL")
    
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
        
        
//        if userType == UserType.photographer {
//            let name = nameTextField.text ?? ""
//            let number = phoneNumberTextField.text ?? ""
//            let email = emailTextField.text ?? ""
//            let currentState = currentStateTextField.text ?? ""
//            let socialMedia = socialMediaTextField.text ?? ""
//            let website = websiteTextField.text ?? ""
//            let about = aboutTextView.text ?? ""
//            
//            bio = Bio(name: name, number: number , email: email, currentState: currentState, instagram: socialMedia, webSite: website, aboutYou: about, password: "")
//            
//            let alert = UIAlertController(title: "Updated", message: "You've updated your bio.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//            
//            
//        } else if userType == UserType.customer {
//            self.navigationController?.popViewController(animated: true)
//        }
    }

    
    @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
    }
    //*********************************************************
    // MARK: - Override Methods
    //*********************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUIWithCurrentUserData()
        
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
    }
    
    @objc func backBarItem() {
        self.navigationController?.popViewController(animated: true)
  
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

        if let bio  = bioRetrive {
            nameTextField.text = bio.name
            emailTextField.text = bio.email
            phoneNumberTextField.text = bio.number
            currentStateTextField.text = bio.currentState
            websiteTextField.text = bio.webSite
            aboutTextView.text = bio.aboutYou
            socialMediaTextField.text = bio.instagram
            
            if let url = URL(string: bio.image) {
                
                self.updateProfileImage(from: url)
                
            }
        }
    }
        
//        // Queries FireStore to get ALL of the users
//        self.db.collection("users").getDocuments { (snapshot, error) in
//            guard let documents = snapshot?.documents else { return }
//            // Loops through each user to find one document for each user
//            for document in documents {
//                // Access to the user
//
//
//                document.get("user")
//                guard let imageURL = bioRetrive.image as? String else {return}
//                self.nameTextField.text =  document.get("name") as? String
//                self.emailTextField.text =  document.get("email") as? String
//                self.phoneNumberTextField.text =  document.get("phoneNumber") as? String
//                self.currentStateTextField.text =  document.get("currentState") as? String
//                self.websiteTextField.text =  document.get("website") as? String
//                self.aboutTextView.text =  document.get("aboutYou") as? String
//                self.socialMediaTextField.text =  document.get("socialMedia") as? String
//                if let url = URL(string: imageURL) {
//
//                self.updateProfileImage(from: url)
//
//                }
//            }
//        }
//    }
}

