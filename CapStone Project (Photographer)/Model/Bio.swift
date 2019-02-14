//
//  Bio.swift
//  CapStone Project (Photographer)
//
//  Created by Dallin Smuin on 2/11/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import Foundation
import CoreData

extension Bio {
    
    convenience init?(name: String, number: Int16, email: String, currentState: String, instagram: String, webSite: String, aboutYou: String, context: NSManagedObjectContext = Stack.context) {
        
        self.init(context: context)
        self.name = name
        self.number = number
        self.email = email
        self.currentState = currentState
        self.instagram = instagram
        self.webSite = webSite
        self.aboutYou = aboutYou
        self.dateOfBirth = Date()
    }
    
}
