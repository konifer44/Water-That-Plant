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
    
    // A test configuration for SwiftUI previews
    static var previewList: CoreDataManager = {
        let controller = CoreDataManager()
        let names = ["Fikus", "Kaktus", "Paproć", "Strelicja", "Bananowiec", "Monstera", "Storczyk"]
        
        // Create 10 example
        for _ in 0..<10 {
            let plant = Plant(context: controller.viewContext)
            plant.id = UUID()
            plant.name = names.randomElement()!
            
            if let image = UIImage(named: "fikus"){
                plant.image = image
            }
           
            plant.selectedRoom = .bathroom
            plant.currentSoilHumidity = 21.37
            plant.currentLighting = 2
            plant.currentFertilizer = 79
            plant.recommendedLightingRawValue = 30
            plant.recommendedTemperature = 22
        }
        
        return controller
    }()

}
