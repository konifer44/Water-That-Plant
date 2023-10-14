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
class AddPlantViewModel: ObservableObject, Identifiable {
    let id: UUID = UUID()
    var viewContext: NSManagedObjectContext = CoreDataManager.shared.viewContext
    
    @Published var editPlant: Plant?
    
    @Published var title: String = "Add new"
    @Published var name = "New plant"
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
    init(){
        _editPlant = Published(initialValue: nil)
    }
    
    init(editPlant: Plant) {
        self.editPlant = editPlant
        
        title = "Edit plant"
        name = editPlant.name
        selectedRoom = editPlant.selectedRoom
        recommendedHumidity = editPlant.recommendedHumidity
        recommendedLighting = editPlant.recommendedLighting
        recommendedFertilization = editPlant.recommendedFertilization
        dateOfBuy = editPlant.dateOfBuy
        isFavourite = editPlant.isFavourite
        peripheralUUID = editPlant.peripheralUUID
        image = editPlant.image
        
    }
    
    
    //MARK: - Methods
    func deletePlant(){
        if let editPlant {
            viewContext.delete(editPlant)
        }
    }
    
    func savePlant(completion: (Bool, PlantErrorType??) ->()){
        if editPlant == nil {
           saveNewPlant()
            
        }
        editPlant?.name = name
        editPlant?.selectedRoom = selectedRoom
        editPlant?.recommendedHumidity = recommendedHumidity
        editPlant?.recommendedLighting = recommendedLighting
        editPlant?.recommendedFertilization = recommendedFertilization
        editPlant?.dateOfBuy = dateOfBuy
        editPlant?.isFavourite = isFavourite
        editPlant?.peripheralUUID = peripheralUUID
        editPlant?.image = image
       
        do {
            editPlant?.objectWillChange.send()
            try viewContext.save()
            completion(true, nil)
        } catch {
            print(error)
            completion(false, .savePlantToCoreDataError)
        }
    }
    
    private func saveNewPlant(){
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
    
    func removePhoto(){
        selectedPhotoItem = nil
        selectedPhoto = nil
    }
    
}

