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
    let imageRef = Database.database().reference().child("users")
    
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
    
        
    }
    //*********************************************************
    // MARK: - Override Methods
    //*********************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if localBioName != "" {
            
            print("not nil!")
            
            bioImageView.image = userImage
            
            nameTextField.text = localBioName
            phoneNumberTextField.text = localBioPhoneNumber
            emailTextField.text = localBioEmail
            currentStateTextField.text = localBioCurrentState
            socialMediaTextField.text = localBioSocialMedia
            websiteTextField.text = localBioWebsite
            aboutTextView.text = localBioAboutYou
        } else {
            print("is nil :(")
            print(localBio)
        }
        
        updateUIWithCurrentUserData()
        
        
        
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
    
    // completion handler o get the image data form your url
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
        
        self.db.collection("users").getDocuments { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var foundDocument: QueryDocumentSnapshot?
                for doc in snapshot!.documents {
                    let email = doc.get("email") as! String
                    if email == Auth.auth().currentUser?.email {
                        //You found the right document!
                        foundDocument = doc
                    }
                }
                
                if let document = foundDocument {
                    // once you add user need to find out how to get that user and put it in
                    
                    let image = document.get("imageURL") as! String
                    
                    if let imageURL = URL(string: image) {
                        self.updateProfileImage(from: imageURL)
                    }
                    let docID = document.documentID
                    let name = document.get("name") as! String
                    let email = document.get("email") as! String
                    let currentState = document.get("currentState") as! String
                    let phoneNumber = document.get("phoneNumber") as! String
                    let socialMedia = document.get("socialMedia") as! String
                    let website = document.get("website") as! String
                    let aboutYou = document.get("aboutYou") as! String
                    print(docID, image, name, email, currentState, phoneNumber, socialMedia, website, aboutYou)

                    DispatchQueue.main.async {
                        self.nameTextField.text = name
                        self.emailTextField.text = email
                        self.currentStateTextField.text = currentState
                        self.phoneNumberTextField.text = phoneNumber
                        self.socialMediaTextField.text = socialMedia
                        self.websiteTextField.text = website
                        self.aboutTextView.text = aboutYou
                    }
                }
            }
        }
    }
}
