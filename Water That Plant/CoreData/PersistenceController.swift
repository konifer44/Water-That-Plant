//
//  File.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 03.06.23.
//

import Foundation
import CoreData

class PersistenceController: ObservableObject {
    // A singleton for our entire app to use
    static let shared = PersistenceController()
    
    // Storage for Core Data
    let container: NSPersistentContainer
    
    // A test configuration for SwiftUI previews
    static var previewList: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        
        // Create 10 example
        for _ in 0..<10 {
            let plant = Plant(context: controller.container.viewContext)
            plant.name = "Example Plant"
            plant.isFavourite = Bool.random()
        }
        
        return controller
    }()
    
    static var previewPlant: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
      
        let plant = Plant(context: controller.container.viewContext)
        plant.name = "Example Plant"
        plant.isFavourite = Bool.random()
        
        
        return controller
    }()
    
    // An initializer to load Core Data, optionally able
    // to use an in-memory store.
    init(inMemory: Bool = false) {
        // If you didn't name your model Main you'll need
        // to change this name below.
        container = NSPersistentContainer(name: "Plant")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}