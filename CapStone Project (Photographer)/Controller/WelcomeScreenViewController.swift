//
//  WelcomeScreenViewController.swift
//  CapStone Project (Photographer)
//
//  Created by Dallin Smuin on 2/5/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import UIKit

enum UserType {
    case customer
    case photographer
}

class WelcomeScreenViewController: UIViewController {
    
    var userType: UserType?
    
    //*********************************************************
    // MARK: - Outlets
    //*********************************************************
    @IBOutlet weak var customerButton: UIButton!
    @IBOutlet weak var photographerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Round Corners
        self.customerButton.layer.cornerRadius = 30
        self.photographerButton.layer.cornerRadius = 30
    }
    
    //*********************************************************
    // MARK: - Actions
    //*********************************************************
    
    @IBAction func customerButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "customerSegue", sender: sender)
    }
    
    // Helps navitgate where the customer goes. (Water)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "customerSegue", let listPhotographersTableViewController = segue.destination as? ListPhotographersTableViewController {
                listPhotographersTableViewController.userType = .customer
        }
    }
    
    @IBAction func photographerButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "photographerSegue", sender: sender)
    }
    
    

    
}
