//
//  File.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 03.06.23.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager: ObservableObject {
    // A singleton for our entire app to use
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer (name: "Plant")
        persistentContainer.loadPersistentStores{(description,error)in
            if let error = error {
                fatalError ("Unable to initialize Core Data Stack \(error)")
            }
        }
    }
}
