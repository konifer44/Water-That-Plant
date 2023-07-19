//
//  PlantHydrationTile.swift
//  WaterThatPlant
//
//  Created by Jan Konieczny on 26.07.22.
//

import SwiftUI


struct PlantStatsTile: View {
    @State var plant: Plant
    let title: String
    let progresBarColor: Color
    let iconColor: Color
    
    init(plant: Plant, type: PlantStatsTileType) {
        self.plant = plant
        
        let model = PlantStatsTileModel(type: type)
        self.title = model.title
        self.progresBarColor = model.progresBarColor
        self.iconColor = model.iconColor
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(alignment: .leading){
                HStack {
                    Image(systemName: "drop")
                        .foregroundStyle(iconColor)
                        .font(.title2)
                    Text(title)
                        .font(.title2)
                }
                Text("Last dose: 3 days ago")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 110)
            .background(Color(uiColor: .systemGray6))
            .cornerRadius(30)
            .offset(x: 100)
            .padding(.trailing, 100)
            
            
            ProgressBar(progress: 90.0, color: progresBarColor, title: "", icon: "")
                .frame(maxWidth: 115)
        }
    }
}

struct PlantStatsTile_Previews: PreviewProvider {
    static var previews: some View {
        PlantStatsTile(plant: previewPlant, type: .hydration)
        PlantStatsTile(plant: previewPlant, type: .fertilizer)
    }
}



    
