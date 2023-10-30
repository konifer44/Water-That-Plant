////
////  PlantViewModel.swift
////  Water That Plant
////
////  Created by Jan Konieczny on 14.06.23.
////
//
//import Foundation
//import SwiftUI
//import CoreData
//
//class PlantViewModel: ObservableObject {
//    @Published var plant: Plant
//   
//    init(plant: Plant) {
//        self.plant = plant
//    }
//    
//    func savePlant(completion: (Bool, PlantErrorType?) ->()){
//        do {
//            try CoreDataManager.shared.viewContext.save()
//            completion(true, nil)
//        } catch {
//            completion(false, .savePlantToCoreDataError)
//        }
//    }
//    
//    func deletePlant(completion: (Bool, PlantErrorType?)->()){
//        CoreDataManager.shared.viewContext.delete(plant)
//        completion(true, nil)
//    }
//    
//    func cancelChanges() {
//        CoreDataManager.shared.viewContext.rollback()
//    }
//    
//    func plantHasChanges() -> Bool {
//        return plant.hasChanges
//    }
//}

