//
//  ListPhotographersTableViewController.swift
//  CapStone Project (Photographer)
//
//  Created by Dallin Smuin on 2/7/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import UIKit

import Firebase

class ListPhotographersTableViewController: UITableViewController {
    
    //*********************************************************
    // MARK: - Properties
    //*********************************************************
    
    var bio = [Bio]()
    
    var db: Firestore = Firestore.firestore()
  
    // this is the bucket to contain water.
    var userType: UserType?
    
    //*********************************************************
    // MARK: - Override Methods
    //*********************************************************
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUsersFromFireStore()

    }
    
    func updateUsersFromFireStore() {
        //  Query FireStore to get the snapshot of all of the users
        self.db.collection("users").getDocuments { (snapshot, error) in
            // Convert the snapshot to documents
            guard let documents = snapshot?.documents else {return}
            var users: [Bio] = []
            // Loop through the documents
            for document in documents {
                guard let name = document.get("name") as? String,
                 let email = document.get("email") as? String,
                 let number = document.get("phoneNumber") as? String,
                 let currentState = document.get("currentState") as? String,
                 let webSite = document.get("website") as? String,
                 let aboutYou = document.get("aboutYou") as? String,
                 let image = document.get("imageURL") as? String,
                 let instagram = document.get("socialMedia") as? String else { return }
                // Convert a single document into a bio object
                if let convertDocumentBio = Bio(name: name, number: number, email: email
                    , currentState: currentState, instagram: instagram, webSite: webSite, aboutYou: aboutYou, password: "", image: image) {
                    // Store each bio into a new array
                    users.append(convertDocumentBio)
                }
            }
            // update your bio array on line 17 to be the new array you just created
            DispatchQueue.main.async {
                self.bio = users
                // reload the tableview
                self.tableView.reloadData()
            }

        }
    }

    //*********************************************************
    // MARK: - Table view data source
    //*********************************************************


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        return bio.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bioCell", for: indexPath)

       // get the Bio that is associated with the cell
        let bio = self.bio[indexPath.row]
        
        cell.textLabel?.text = bio.name

        return cell
    }
    
    //*********************************************************
    // MARK: - Navigation
    //*********************************************************
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let bioVC = segue.destination as? BioViewController,
            let seletedRow = tableView.indexPathForSelectedRow?.row else { return }        
        
        // Water
        let bio = self.bio[seletedRow]
        
        // This is the Water that needs to find the bucket on the next file.
        if segue.identifier == "bioSegue", let bioViewController = segue.destination as? BioViewController {
            bioViewController.userType = .customer
            bioVC.loadViewIfNeeded()
            
            // bioretrive is the jug passing the water into the jug meaning BioViewController
            bioVC.bioRetrive = bio
            
            bioVC.logoutButton.isEnabled = false
            bioVC.editButton.isHidden = true
            bioVC.saveButton?.title = "Back"
            bioVC.logoutButton?.title = ""
        }
    }
}
