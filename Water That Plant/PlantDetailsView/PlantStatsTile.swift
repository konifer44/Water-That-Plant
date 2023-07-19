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
    let color: Color
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(alignment: .leading){
                HStack {
                    Image(systemName: "drop")
                        .foregroundStyle(Color.brownOliveGreenGradient)
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
            
            
            CircleIndicator(progress: .constant(11.0), color: color)
                .frame(maxWidth: 120)
        }
    }
}

struct PlantStatsTile_Previews: PreviewProvider {
    @State static var plant = previewPlant
    
    static var previews: some View {
        PlantStatsTile(plant: plant, title: "Fertilizer", color: .brown)
    }
}



    
