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
    @Published var presentedPlantPath = [Plant]()
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    func addNewPlant(){
        let plant = Plant(context: moc)
        let names = ["Fikus", "Kaktus", "Paproć", "Strelicja", "Bananowiec", "Monstera", "Storczyk"]
        plant.name = names.randomElement()!
        plant.selectedRoom = .defaultRoom
        
        plant.recommendedHumidity = .medium
        plant.recommendedLighting = .medium
        plant.recommendedFertilization = .onceAWeek
        
        plant.dateOfBuy = Date()
        plant.isFavourite = false
        
        do {
            try moc.save()
            presentedPlantPath.append(plant)
        } catch {
            
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
    
    
     func delete(at offsets: IndexSet, in plants: [Plant]) {
        for offset in offsets {
            let plant = plants[offset]
            moc.delete(plant)
        }
        try? moc.save()
    }
    
    
    fileprivate func getScrollOffset(_ geometry: GeometryProxy) -> CGFloat {
        geometry.frame(in: .global).minY
    }
    
    
    func getOffsetForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
            let offset = getScrollOffset(geometry)
            
            // Image was pulled down
            if offset > 0 {
                return -offset
            }
            
            return 0
        }
    
    func getHeightForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geometry)
        let imageHeight = geometry.size.height

        if offset > 0 {
            return imageHeight + offset
        }

        return imageHeight
    }
}
