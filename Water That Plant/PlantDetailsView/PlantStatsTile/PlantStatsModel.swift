//
//  PlantStatsModel.swift
//  Water That Plant
//
//  Created by konieczny on 19/07/2023.
//

import Foundation
import SwiftUI

enum PlantStatsTileType: CaseIterable{
    case hydration
    case fertilizer
}


struct PlantStatsTileModel {
    let title: String
    let progresBarColor: Color
    let iconColor: Color
    
    init(type: PlantStatsTileType){
        switch type {
        case .hydration:
            title = "Hydration"
            progresBarColor = .blue
            iconColor = .blue
            
        case .fertilizer:
            title = "Fertilizer"
            progresBarColor = .brown
            iconColor = .brown
        }
    }
   
}
