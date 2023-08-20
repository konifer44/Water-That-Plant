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
    //MARK: - Public properties
    @Published var sortDescriptor: SortDescriptors = .name
    @Published var addPlantViewModel: AddPlantViewModel?
    
    let viewContext: NSManagedObjectContext

    
    //MARK: - Init
    init(viewContext: NSManagedObjectContext){
        self.viewContext = viewContext
    }
    
    
    //MARK: - Public methods
  
}


enum SortDescriptors: String, CaseIterable {
    var id: Self { self }
    
    case name = "Name"
    case date = "Date"
    case room = "Room"
    
    
    func descriptor() -> SortDescriptor<Plant> {
        switch self {
        case .name:
            return SortDescriptor(\.nameRawValue, order: .forward)
        case .date:
            return SortDescriptor(\.dateOfBuyRawValue, order: .forward)
        case .room:
            return SortDescriptor(\.selectedRoomRawValue, order: .forward)
        }
    }
}
