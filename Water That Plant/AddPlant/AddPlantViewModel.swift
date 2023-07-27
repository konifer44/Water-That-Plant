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
    let viewContext: NSManagedObjectContext
   
    @Published var name = "New Plant"
    @Published var selectedRoom: RoomsType = .defaultRoom
    @Published var recommendedHumidity: RecommendedHumidityType = .medium
    @Published var recommendedLighting: RecommendedLightingType = .medium
    @Published var recommendedFertilization: RecommendedFertilizationType = .onceAWeek
    @Published var dateOfBuy = Date()
    @Published var isFavourite = false
    @Published var peripheralUUID: UUID?
    @Published var image: UIImage = UIImage()
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
    init(viewContext: NSManagedObjectContext){
        self.viewContext = viewContext
      
    }
    
    
//MARK: - Methods
  func savePlant(completion: (Bool, PlantErrorType??) ->()){
        let newPlant = Plant(context: viewContext)
        newPlant.id = UUID()
        newPlant.name = name
        newPlant.selectedRoom = selectedRoom
        newPlant.recommendedHumidity = recommendedHumidity
        newPlant.recommendedLighting = recommendedLighting
        newPlant.recommendedFertilization = recommendedFertilization
        newPlant.dateOfBuy = dateOfBuy
        newPlant.isFavourite = isFavourite
        newPlant.peripheralUUID = peripheralUUID
        newPlant.image = image
        
        do {
            try viewContext.save()
            completion(true, nil)
        } catch {
            print(error)
            completion(false, .savePlantToCoreDataError)
        }
    }
    
    func clearView(){
        name = ""
        selectedRoom = .defaultRoom
        recommendedHumidity = .medium
        recommendedLighting = .medium
        recommendedFertilization = .onceAWeek
        dateOfBuy = Date()
        isFavourite = false
        peripheralUUID = nil
        image = UIImage()
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
           image = selectedPhoto
        }
    }
}

