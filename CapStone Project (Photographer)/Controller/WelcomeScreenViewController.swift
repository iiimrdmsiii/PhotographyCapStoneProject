//
//  WelcomeScreenViewController.swift
//  CapStone Project (Photographer)
//
//  Created by Dallin Smuin on 2/5/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import UIKit

class WelcomeScreenViewController: UIViewController {
    
    
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
    

    
}
