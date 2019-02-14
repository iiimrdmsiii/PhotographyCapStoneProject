//
//  BioController.swift
//  CapStone Project (Photographer)
//
//  Created by Dallin Smuin on 2/11/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import Foundation
import CoreData

class BioController {
    
    static let shareController = BioController()
    
    // Hold Bio
    var bios: [Bio] {
        // get the bios from the CoreData if they exist.
        let request: NSFetchRequest<Bio> = Bio.fetchRequest()
        
        do {
            return try Stack.context.fetch(request)
        } catch {
            return []
        }
    }
    
    // Manage the bio
    
    // create bio
    func createBio(name: String, number: Int16, email: String, currentState: String, instagram: String, webSite: String, aboutYou: String) {
        let _ = Bio(name: name, number: number, email: email, currentState: currentState, instagram: instagram, webSite: webSite, aboutYou: aboutYou)
        save()
    }
    
    // delete bio
    func delete(bio: Bio) {
        Stack.context.delete(bio)
        save()
    }
    
    // save bio
    func save() {
        do {
            try Stack.context.save()
        } catch {
            print("Couldn't save Bio to CoreData.")
        }
    }
}
