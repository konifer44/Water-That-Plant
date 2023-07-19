//
//  PlantDetailView.swift
//  WaterThatPlant
//
//  Created by Jan Konieczny on 25.07.22.
//

import SwiftUI


struct PlantDetailView: View {
    @State var plant: Plant
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                DetailTopBar(plant: plant)
                    .frame(height: 330)//geometry.size.height / 3)
               
                ScrollView {
                    VStack(alignment: .leading){
                        HStack{
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.oliveGreen)
                                .font(.title2)
                            Text("Plant overview")
                                .font(.title3)
                            Spacer()
                        }
                        .padding()
                        
                        PlantStatsTile(plant: plant, type: .hydration)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                        
                        PlantStatsTile(plant: plant, type: .hydration)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                        
                        PlantStatistics()
                            .frame(height: geometry.size.height / 3)
                            .padding()
                    }
                }
                .edgesIgnoringSafeArea(.top)
                //.navigationTitle("\(plant.name) in the \(plant.room)")
            .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct PlantDetailView_Previews: PreviewProvider {
    @State static var plant = previewPlant
    
    static var previews: some View {
        PlantDetailView(plant: plant)
    }
}





