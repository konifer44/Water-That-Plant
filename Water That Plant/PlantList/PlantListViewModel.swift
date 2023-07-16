//
//  PlantListViewModel.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 17.06.23.
//

import Foundation
import SwiftUI
import CoreData

class PlantListViewModel: ObservableObject {
    let moc: NSManagedObjectContext
     
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    func addNewPlant(completion: (Plant?, PlantErrorType?)->()){
        let plant = Plant(context: moc)
        plant.name = "New Plant"
        plant.selectedRoom = .defaultRoom
        
        plant.recommendedHumidity = .medium
        plant.recommendedLighting = .medium
        plant.recommendedFertilization = .onceAWeek
        
        plant.dateOfBuy = Date()
        plant.isFavourite = false
        
        do {
            try moc.save()
            completion(plant, nil)
        } catch {
            completion(nil, .addNewPlantError)
        }
    }
    
    
    func savePlant(completion: (Bool, PlantErrorType??) ->()){
        do {
            try moc.save()
            completion(true, nil)
        } catch {
            completion(false, .savePlantToCoreDataError)
        }
    }
    
    func deletePlant(plant: Plant){
        moc.delete(plant)
    }
    
   
}
