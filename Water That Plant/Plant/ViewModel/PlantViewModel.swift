//
//  PlantViewModel.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 14.06.23.
//

import Foundation
import SwiftUI
import CoreData

class PlantViewModel: ObservableObject {
    let moc: NSManagedObjectContext
    @Published var plant: Plant
   
    init(plant: Plant, moc: NSManagedObjectContext) {
        self.plant = plant
        self.moc = moc
    }
    
    func savePlant(completion: (Bool, PlantErrorType?) ->()){
        do {
            try moc.save()
            completion(true, nil)
        } catch {
            completion(false, .savePlantToCoreDataError)
        }
    }
    
    func deletePlant(completion: (Bool, PlantErrorType?)->()){
        moc.delete(plant)
        completion(true, nil)
    }
    
    func cancelChanges() {
        moc.rollback()
    }
    
    func plantHasChanges() -> Bool {
        return plant.hasChanges
    }
}
