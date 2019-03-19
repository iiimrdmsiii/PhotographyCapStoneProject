//
//  Bio.swift
//  CapStone Project (Photographer)
//
//  Created by Dallin Smuin on 2/11/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import Foundation
import CoreData

struct Bio {
    
    var name: String
    var number: String
    var email: String
    var currentState: String
    var instagram: String
    var webSite: String
    var aboutYou: String
    var password: String
    var dateOfBirth: Date
    var image: String
    
    init?(name: String, number: String, email: String, currentState: String, instagram: String, webSite: String, aboutYou: String, password: String, image: String) {
        
        
        self.name = name
        self.number = number
        self.email = email
        self.currentState = currentState
        self.instagram = instagram
        self.webSite = webSite
        self.aboutYou = aboutYou
        self.password = password
        self.dateOfBirth = Date()
        self.image = image
        
    }
    
}
