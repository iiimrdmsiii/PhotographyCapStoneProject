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

class CreateBioTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //*********************************************************
    // MARK: - Properties
    //*********************************************************
    
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
    @IBOutlet weak var registerButtonTapped: UIButton!
    
    //*********************************************************
    // MARK: - ViewDidLoad Method
    //*********************************************************

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
        
        // Mark: DOBFormatter
        updateDOBLabel(date: dateOfBirthDatePicker.date)
        
        dateOfBirthDatePicker.isHidden = true

    }
    
    //*********************************************************
    // MARK: - Register Button Action
    //*********************************************************
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        // update
        guard let name = nameTextField.text,
        let email = emailTextField.text,
        let password = passwordTextField.text,
        let repeatPassword = repeatPasswordTextField.text,
        let phone = phoneNumber.text,
//            let phoneNumber = Int16(phone),
        let emailContact = emailContactTextField.text,
        let currentState = currentStateTextField.text,
        let instagram = instagramTextField.text,
        let webSite = websiteTextField.text,
        let aboutYou = aboutYouTextView.text else { return }
        
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
        
        self.navigationController?.popViewController(animated: true)
        
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
    
    func updateDOBLabel(date: Date) {
        
        dateOfBirthLabel.text = DOBDateFormatter.dateOfBirthFormatter.string(from: date)
        
    }
    
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
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDOBLabel(date: dateOfBirthDatePicker.date)
    }
    
}

