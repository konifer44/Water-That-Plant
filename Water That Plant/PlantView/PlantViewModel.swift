//
//  PlantViewModel.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 14.06.23.
//

import Foundation
import SwiftUI

class PlantViewModel: ObservableObject {
    var moc =  PersistenceController.shared.container.viewContext
    
    @Published var plant: Plant
    @Published var newName: String
    @Published var selectedRoom: RoomsType
    @Published var selectedRecommendedHumidity: RecommendedHumidityType
    @Published var selectedRecommendedFertilization: RecommendedFertilizationType
    @Published var selectedRecommendedLighting: RecommendedLightingType
    @Published var selectedDate: Date
    @Published var selectedIsFavourite: Bool
    @Published var selectedPeripheralUUID: UUID?
    
    
    init(plant: Plant) {
        _plant = Published(initialValue: plant)
        _newName = Published(initialValue: plant.name ?? "")
        _selectedRoom = Published(initialValue: plant.selectedRoom)
        _selectedRecommendedHumidity = Published(initialValue: plant.recommendedHumidity)
        _selectedRecommendedFertilization = Published(initialValue: plant.recommendedFertilization)
        _selectedRecommendedLighting = Published(initialValue: plant.recommendedLighting)
        _selectedDate = Published(initialValue: plant.dateOfBuy ?? Date())
        _selectedIsFavourite = Published(initialValue: plant.isFavourite)
        _selectedPeripheralUUID = Published(initialValue: plant.peripheralUUID)
       
    }
    
    
    
    func savePlant(completion: (Bool, String?) ->()){
        do {
            try moc.save()
            completion(true, nil)
        } catch {
            completion(false, "Błąd w zapisie do CoreData")
        }
    }
    
    func cancelChanges() {
        moc.rollback()
    }
    
    func hasChanges() -> Bool {
        plant.name = newName
        plant.selectedRoom = selectedRoom
        plant.recommendedHumidity = selectedRecommendedHumidity
        plant.recommendedFertilization = selectedRecommendedFertilization
        plant.recommendedLighting = selectedRecommendedLighting
        plant.dateOfBuy = selectedDate
        plant.isFavourite = selectedIsFavourite
        plant.peripheralUUID = selectedPeripheralUUID
        
        return plant.hasChanges
    }
}
