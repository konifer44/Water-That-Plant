//
//  PreviewPlant.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 16.07.23.
//

import Foundation
import CoreData
import UIKit
var previewPlant: Plant = {
    let names = ["Fikus", "Kaktus", "Paproć", "Strelicja", "Bananowiec", "Monstera", "Storczyk"]
   
    var plant = Plant(context: CoreDataManager.shared.viewContext)
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
    return plant
}()
