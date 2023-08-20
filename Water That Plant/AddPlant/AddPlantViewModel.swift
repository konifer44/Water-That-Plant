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
        let temporaryViewContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        self.plant = Plant(context: temporaryViewContext)
    }
    
    init(editPlant: Plant) {
        self.plant = editPlant
    }
    
    
    //MARK: - Methods
    func deletePlant(){
        viewContext.delete(plant)
    }
    
    func savePlant(completion: (Bool, PlantErrorType??) ->()){
        var newPlant = Plant(context: viewContext)
        plant = newPlant
        
        do {
            try viewContext.save()
            completion(true, nil)
        } catch {
            print(error)
            completion(false, .savePlantToCoreDataError)
        }
    }
    
    func clearView(){
      
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
    
    func removePhoto(){
        selectedPhotoItem = nil
        selectedPhoto = nil
    }
    
}

