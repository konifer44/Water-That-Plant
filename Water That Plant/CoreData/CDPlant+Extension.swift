//
//  CDPlant+Extension.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 04.06.23.
//

import Foundation
import SwiftUI
import CoreData

extension Plant {
    var name: String {
        get {
            return self.nameRawValue ?? ""
        }
        
        set {
            self.nameRawValue = newValue
        }
    }
    
    var dateOfBuy: Date {
        get {
            return self.dateOfBuyRawValue ?? Date()
        }
        
        set {
            self.dateOfBuyRawValue = newValue
        }
    }
    
    var selectedRoom: RoomsType {
        get {
            return RoomsType(rawValue: self.selectedRoomRawValue ?? "") ?? .defaultRoom
        }
        
        set {
            self.selectedRoomRawValue = newValue.rawValue
        }
    }
    
    var recommendedLighting: RecommendedLightingType {
        get {
            return RecommendedLightingType(rawValue: Int(self.recommendedLightingRawValue)) ?? .medium
        }
        
        set {
            self.recommendedLightingRawValue = Int16(newValue.rawValue)
        }
    }
    
    var recommendedFertilization: RecommendedFertilizationType {
        get {
            return RecommendedFertilizationType(rawValue: self.recommendedFertilizationRawValue ?? "") ?? .onceAWeek
        }
        
        set {
            self.recommendedFertilizationRawValue = newValue.rawValue
        }
    }
    
    var recommendedHumidity: RecommendedHumidityType {
        get {
            return RecommendedHumidityType(rawValue: Int(self.recommendedSoilHumidityRawValue)) ?? .medium
        }
        
        set {
            self.recommendedSoilHumidityRawValue =  Int16(newValue.rawValue)
        }
    }
    
    var image: UIImage {
        get {
            if let data = self.imageData,
               let image = UIImage(data: data) {
                return image
            } else {
                return UIImage()
            }
           
        }
        
        set {
            self.imageData = newValue.pngData()
        }
    }
  
}



enum RoomsType: String, CaseIterable {
    case livingRoom = "Living Room"
    case kitchen = "Kitchen"
    case bathroom = "Bathroom"
    case bedroom = "Bedroom"
    case defaultRoom = "Default"
}


enum RecommendedHumidityType: Int, CaseIterable {
    case low = 0
    case mediumLow = 1
    case medium = 2
    case mediumHigh = 3
    case high = 4
    
    var range: CountableClosedRange<Int> {
        switch self {
        case .low:    return 0...19
        case .mediumLow:    return 20...39
        case .medium: return 40...59
        case .mediumHigh:    return 60...79
        case .high:      return 80...100
        }
    }
}


enum RecommendedLightingType: Int, CaseIterable {
    case low = 0
    case medium = 1
    case high = 2
    
    var range: CountableClosedRange<Int> {
        switch self {
        case .low:    return 0...39
        case .medium: return 40...79
        case .high:      return 80...100
        }
    }
}

enum RecommendedFertilizationType: String, CaseIterable {
    case onceAWeek = "Every 1 week"
    case onceTwoWeeks = "Every 2 weeks"
    case onceThreeWeeks = "Every 3 weeks"
    case onceFourWeeks = "Every 4 weeks"
}
