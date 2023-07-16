//
//  PlantTile.swift
//  WaterThatPlant
//

import SwiftUI

struct PlantTile: View {
    let plant: Plant
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Image(uiImage: plant.image)
                    .resizable()
                HStack{
                    Text(plant.name)
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding()
                        .padding(.leading, 5)
                    Spacer()
                }
                .frame(maxHeight: geometry.size.height / 5)
                .background(Color(uiColor: .systemGray))
            }
            .background(Color.red)
            
            .cornerRadius(30)
            .shadow(color: .gray.opacity(0.2), radius: 5)
            .edgesIgnoringSafeArea(.all)
        }
        .aspectRatio(4/5, contentMode: .fit)
    }
}

struct PlantTile_Previews: PreviewProvider {
    static var previews: some View {
        PlantTile(
            plant: previewPlant
        )
        
        .frame(height: 150)
    }
}
