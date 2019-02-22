//
//  BioViewController.swift
//  CapStone Project (Photographer)
//
//  Created by Dallin Smuin on 2/8/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import UIKit

class BioViewController: UIViewController {
    
//    self.navigationController?.pushViewController(nextViewController, animated: true)

    //      performSegue(withIdentifier: "mySegueID", sender: nil)
    
    //*********************************************************
    // MARK: - Properties
    //*********************************************************
    
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
//        let phoneNumber = Int16(phoneNumberTextField!.text!) ?? 0
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
    
    //*********************************************************
    // MARK: - Override Methods
    //*********************************************************

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let photographerIndex = BioController.shareController.photographerThatJustRegistered {
            let bio = BioController.shareController.bios[photographerIndex]
            updateView(with: bio)
        }
    }
    
    //*********************************************************
    // MARK: -
    //*********************************************************
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
}
