//
//  Stack.swift
//  CapStone Project (Photographer)
//
//  Created by Dallin Smuin on 2/11/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import Foundation
import CoreData

// Bone to CoreData from the Entity
enum Stack {
    
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores() { (storeDescription, error) in
            print(storeDescription)
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext {
        return container.viewContext
    }
    
}
