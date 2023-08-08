//
//  AddPlantViewModel.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 27.07.23.
//

import Foundation
import SwiftUI
import PhotosUI
import CoreData

@MainActor
class AddPlantViewModel: ObservableObject {
    let viewContext: NSManagedObjectContext = CoreDataManager.shared.viewContext
   
    @Published var plant: Plant
    @Published var selectedPhotoItem: PhotosPickerItem? {
        didSet {
            convertPhoto()
        }
    }
    @Published var selectedPhoto: UIImage? {
        didSet {
           setPhoto()
        }
    }
   
//MARK: - Init
    init(){
        let newPlant = Plant(context: viewContext)

        
        self.plant = newPlant
    }
    
 
    init(editPlant: Plant) {
        self.plant = editPlant
    }
    
    
//MARK: - Methods
  func savePlant(completion: (Bool, PlantErrorType??) ->()){
//        let newPlant = Plant(context: viewContext)
//        newPlant.id = UUID()
//        newPlant.name = name
//        newPlant.selectedRoom = selectedRoom
//        newPlant.recommendedHumidity = recommendedHumidity
//        newPlant.recommendedLighting = recommendedLighting
//        newPlant.recommendedFertilization = recommendedFertilization
//        newPlant.dateOfBuy = dateOfBuy
//        newPlant.isFavourite = isFavourite
//        newPlant.peripheralUUID = peripheralUUID
//        newPlant.image = image
        
        do {
            try viewContext.save()
            completion(true, nil)
        } catch {
            print(error)
            completion(false, .savePlantToCoreDataError)
        }
    }
    
    func clearView(){
//        name = ""
//        selectedRoom = .defaultRoom
//        recommendedHumidity = .medium
//        recommendedLighting = .medium
//        recommendedFertilization = .onceAWeek
//        dateOfBuy = Date()
//        isFavourite = false
//        peripheralUUID = nil
//        image = UIImage()
    }
    
    func removePhoto(){
        selectedPhotoItem = nil
        selectedPhoto = nil
    }
    
    private func convertPhoto(){
        Task {
            if let data = try? await selectedPhotoItem?.loadTransferable(type: Data.self) {
                if let image = UIImage(data: data) {
                    selectedPhoto = image
                }
            }
        }
    }
    
    private func setPhoto(){
        if let selectedPhoto {
            plant.image = selectedPhoto
        }
    }
}

