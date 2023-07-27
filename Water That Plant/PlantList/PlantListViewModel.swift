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
    @Published var presentedPlantPath = [Plant]()
    
    let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext){
        self.viewContext = viewContext
    }
    
    func sortAction(){
        
    }
    
    
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
