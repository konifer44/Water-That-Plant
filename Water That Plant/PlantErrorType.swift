//
//  PlantErrorType.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 17.06.23.
//

import Foundation

enum PlantErrorType: Error {
case addNewPlantError
case savePlantToCoreDataError
case deletePlantError
    
}



extension PlantErrorType: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .addNewPlantError:
            return NSLocalizedString("Adding new plant to CoreData error", comment: "")
        case .savePlantToCoreDataError:
            return NSLocalizedString("Saving plant to CoreData error", comment: "")
        case .deletePlantError:
            return NSLocalizedString("Deleting plant from CoreData error", comment: "")
        }
    }
}
