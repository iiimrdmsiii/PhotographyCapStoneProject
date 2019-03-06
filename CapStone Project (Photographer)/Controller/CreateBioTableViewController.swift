//
//  CreateBioTableViewController.swift
//  CapStone Project (Photographer)
//
//  Created by Dallin Smuin on 2/7/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import FirebaseAuth
import Firebase

class CreateBioTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //*********************************************************
    // MARK: - Properties
    //*********************************************************
    
    var db: Firestore!
    var docRef: DocumentReference!
    
    var imagePicker: UIImagePickerController!
    var nameText = ""
    var dOBFormatter: DOBDateFormatter?
    var isPickerHidden = true
    var image: Image?
    
    var bio: Bio? {
        
        didSet {
            guard let bio = bio else { return }
            
            nameTextField.text = bio.name
            emailTextField.text = bio.email
            passwordTextField.text = bio.password
            repeatPasswordTextField.text = bio.password
            phoneNumber.text = bio.number
            emailTextField.text = bio.email
            currentStateTextField.text = bio.currentState
            instagramTextField.text = bio.instagram
            websiteTextField.text = bio.webSite
            aboutYouTextView.text = bio.aboutYou
            
        }
    }
    
    
    //*********************************************************
    // MARK: - Outlets
    //*********************************************************
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var choosePhotoButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var emailContactTextField: UITextField!
    @IBOutlet weak var currentStateTextField: UITextField!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var dateOfBirthDatePicker: UIDatePicker!
    @IBOutlet weak var instagramTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var aboutYouTextView: UITextView!
    @IBOutlet weak var registerButton: UIButton!
    
    //*********************************************************
    // MARK: - Methods and ViewDidLoad Method
    //*********************************************************

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
        
        // Mark: DOBFormatter
        updateDOBLabel(date: dateOfBirthDatePicker.date)
        
        dateOfBirthDatePicker.isHidden = true
        
        registerButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
        db = Firestore.firestore()
        
        docRef = db.document("users/profile")
        
        firebaseWrite()

    }
    
    
    //*********************************************************
    // MARK: - Register Button Action
    //*********************************************************
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        
        
        // alert for the TextFields
        if nameTextField.text?.isEmpty ?? false || emailTextField.text?.isEmpty ?? false || passwordTextField.text?.isEmpty ?? false || repeatPasswordTextField.text?.isEmpty ?? false || phoneNumber.text?.isEmpty ?? false || emailContactTextField.text?.isEmpty ?? false || emailContactTextField.text?.isEmpty ?? false || currentStateTextField.text?.isEmpty ?? false || instagramTextField.text?.isEmpty ?? false || websiteTextField.text?.isEmpty ?? false || aboutYouTextView.text?.isEmpty ?? false {
            
            let alert = UIAlertController(title: "Warning", message: "Please make sure everything is filled.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            print("Make sure you filled in everything")
        } else {
            print("Went to Bio screen!")
        }
        
        // alert for the Image
//        let uploadImage = UIImage(named: "myImage")
        if imageView.image == nil {
        let alertImage = UIAlertController(title: "Picture", message: "Please add a photo", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertImage.addAction(action)
//        action.setValue(uploadImage, forKey: "image")
        alertImage.popoverPresentationController?.sourceView = sender as? UIView
        
        
            
        present(alertImage, animated: true, completion: nil)
//        alertImage.view.addSubview(imageView)
        }
        
        // update
        
        guard let name = nameTextField.text, !name.isEmpty else {return}
        guard let email = emailTextField.text, !email.isEmpty else {return}
        guard let password = passwordTextField.text, !password.isEmpty else {return}
        guard let repeatPassword = repeatPasswordTextField.text, !repeatPassword.isEmpty  else {return}
        guard let phone = phoneNumber.text, !phone.isEmpty else {
            return
        }
        guard let emailContact = emailContactTextField.text, !emailContact.isEmpty else {return}
        guard let currentState = currentStateTextField.text, !currentState.isEmpty else {return}
        guard let instagram = instagramTextField.text, !instagram.isEmpty else {return}
        guard let webSite = websiteTextField.text, !webSite.isEmpty else {return}
        guard let aboutYou = aboutYouTextView.text, !aboutYou.isEmpty else {return}
        
//        let dataToSave: [String: Any] = ["name": name, "email": email, "phoneNumber": phone, "currentState": currentState, "socialMedia": instagram, "website": webSite, "email": email]
//        docRef.setData(dataToSave) { (error) in
//            if let error = error {
//                print("Oh no! Got an error: \(error.localizedDescription)")
//            } else {
//                print("Data has been saved!")
//            }
//        }
        
        if let bio = bio {
            
            bio.name = name
            bio.email = email
            bio.password = password
            bio.password = repeatPassword
            bio.number = phone
            bio.email = emailContact
            bio.currentState = currentState
            bio.instagram = instagram
            bio.webSite = webSite
            bio.aboutYou = aboutYou
    
        } else {
            // create
            BioController.shareController.createBio(name: name, number: phone, email: email, currentState: currentState, instagram: instagram, webSite: webSite, aboutYou: aboutYou, password: password)
            
        }
        
        performSegue(withIdentifier: "bioFromRegisterSegue", sender: self)
        
    }

    
    //*********************************************************
    // MARK: - UIImageView for picking photos from the library
    //*********************************************************
    
    // able to selet image
    func updateView() {
        
        guard let image = image else { return }
        if let imageData = image.imageData,
            let images = UIImage(data: imageData) {
            choosePhotoButton.setTitle("", for: .normal)
            choosePhotoButton.setBackgroundImage(images, for: .normal)
        } else {
            choosePhotoButton.setTitle("Choose Image", for: .normal)
            choosePhotoButton.setBackgroundImage(nil, for: .normal)
        }
    }
    
    // alert buttons when tapped choosePhotoButtonTapped
    @IBAction func chooseButtonPhotoTapped(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancel)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "photo library", style: .default, handler: { (_) in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        } 
        
            
            present(alertController, animated: true, completion: nil)
        }
        
        // Image picking functionality - When a user want to pick image's they will recive an alert notification of the want to use the camera or not. OR select photos from the photo library.
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let selectedImage = info[.originalImage] as? UIImage {
                imageView.image = selectedImage
                image?.imageData = selectedImage.pngData()
                dismiss(animated: true, completion: nil)
            }
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }

    //*********************************************************
    // MARK: - Date of Birth DatePicker
    //*********************************************************
    
    // Whenever you change the date the label will change the the date youve changed to.
    func updateDOBLabel(date: Date) {
        
        dateOfBirthLabel.text = DOBDateFormatter.dateOfBirthFormatter.string(from: date)
        
    }
    
    // control the heights
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(44)
        let largeCellHeight = CGFloat(200)
        
        switch (indexPath) {
        case [0,0]:
            return 380
            
        case [1,0]:
            return 160
            
        case [2,0]:
            return isPickerHidden ? normalCellHeight : largeCellHeight
            
        case [3,0]:
            return 100

        case [4,0]:
            return largeCellHeight
            
        case [5,0]:
            return 50
            
        default:
            return normalCellHeight
        }
    }
    
    // Picked row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath) {
        case [2,0]:
            dateOfBirthDatePicker.isHidden = !dateOfBirthDatePicker.isHidden
            isPickerHidden = !isPickerHidden
            
            dateOfBirthLabel.textColor = isPickerHidden ? .black :
            tableView.tintColor
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default:
            break
        }
    }
    
    // action for the datePickerChanged
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDOBLabel(date: dateOfBirthDatePicker.date)
    }
    
    //*********************************************************
    // MARK: - Handle the register and FireBase
    //*********************************************************
    
    @objc func handleRegister() {

        guard let image = imageView.image else { return }
        guard let name = nameTextField.text else { return }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }


        firebaseWrite()
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil && user != nil {
                print("User created!")
                
                // Upload the profile image to Firebase Storage
                
                self.uploadProfileImage(image) { url in
                    
                    if url != nil {
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        
                        changeRequest?.photoURL = url
                        changeRequest?.displayName = name
                        
                        
                        changeRequest?.commitChanges { error in
                            if error == nil {
                                print("User display name changed!")
                                
                                 // save the profile data to Firebase Database
                                self.saveBioFirebase(profileImageURL: url!) { success in
                                    if success {
                                        self.dismiss(animated: true, completion: nil)
                                    } else {
                                        self.restForm()
                                    }
                                }
                                
                            } else {
                                print("Error: \(error!.localizedDescription)")
                                self.restForm()
                            }
                        }
                    } else {
                        self.restForm()
                    }
                }
                
                // dismiss the veiw
            } else {
                self.restForm()
            }
        }
    }
    
    // Upload the image from Firebase
    func uploadProfileImage(_ image: UIImage, completion: @escaping ((_ url: URL?) ->())) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("user/\(uid)")
        
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        
        storageRef.putData(imageData, metadata: metaData) { (metaData, error) in
            if error == nil, metaData != nil {
                
                // success
                storageRef.downloadURL { (url, error) in
                    completion(nil)
                }
            } else {
                // fail
                completion(nil)
            }
        }
    }
    
    // save the image on to firebase.
    func saveBioFirebase(profileImageURL: URL, completion: @escaping ((_ success: Bool) -> ())) {
        print("saveBioFirebase func")
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        let userObject = [
            "photoURL": profileImageURL.absoluteString
            ] as [String:Any]
        
        databaseRef.setValue(userObject) { error, ref in
            completion(error == nil)
        }
    }
    
    // catches the error to alert you for signing up.
    func restForm() {
        
        let alert = UIAlertController(title: "Error signing up", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // Add a new document with a generated ID
    
    private func firebaseWrite() {
        var ref: DocumentReference? = nil
            ref = db.collection("users").addDocument(data: [
                "image" : "/users/profile",
                "name" : nameTextField.text!,
                "email" : emailTextField.text!,
                "currentState" : currentStateTextField.text!,
                "phoneNumber" : phoneNumber.text!,
                "socialMedia" : instagramTextField.text!,
                "website" : websiteTextField.text!,
                "aboutYou" : aboutYouTextView.text,
                ]) { err in
                    if let  err = err {
                        print("Error adding document: \(err)")
    
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    
            db.collection("users").getDocuments() { ( querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                }
            }
    }
}

