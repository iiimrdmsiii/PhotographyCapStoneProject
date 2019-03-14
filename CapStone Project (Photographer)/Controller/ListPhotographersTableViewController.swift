//
//  ListPhotographersTableViewController.swift
//  CapStone Project (Photographer)
//
//  Created by Dallin Smuin on 2/7/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import UIKit

class ListPhotographersTableViewController: UITableViewController {
    
    //*********************************************************
    // MARK: - Properties
    //*********************************************************
    
    var bio = [Bio]()
  
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
        
        

    }

    //*********************************************************
    // MARK: - Table view data source
    //*********************************************************


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        return BioController.shareController.bios.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bioCell", for: indexPath)

       // get the Bio that is associated with the cell
        let bio = BioController.shareController.bios[indexPath.row]
        
        cell.textLabel?.text = bio.name

        return cell
    }
    
    //*********************************************************
    // MARK: - Navigation
    //*********************************************************
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let bioVC = segue.destination as? BioViewController,
            let seletedRow = tableView.indexPathForSelectedRow?.row else { return }        
        
        bioVC.loadViewIfNeeded()
        let bio = BioController.shareController.bios[seletedRow]
        
        if segue.identifier == "bioSegue" {
            bioVC.bio = bio
            
            bioVC.logoutButton.isEnabled = false
            bioVC.editButton.isHidden = true
            bioVC.saveButton?.title = "Back"
            bioVC.logoutButton?.title = ""
            
        }
    }
}
