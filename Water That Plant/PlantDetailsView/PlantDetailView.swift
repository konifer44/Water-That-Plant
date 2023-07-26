//
//  PlantDetailView.swift
//  WaterThatPlant
//
//  Created by Jan Konieczny on 25.07.22.
//

import SwiftUI


struct PlantDetailView: View {
    @State var plant: Plant
    private let topBarHeight: CGFloat = 330
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0){
                PlantDetail(plant: plant, height: geometry.size.height / 2.5)
                  
                ScrollView {
                    VStack(alignment: .leading){
                        Spacer(minLength: 30)
                        PlantStatsTile(plant: plant, type: .hydration)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                        
                        PlantStatsTile(plant: plant, type: .hydration)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                        
                        PlantStatistics()
                        //.frame(height: geometry.size.height / 3)
                            .padding()
                    }
                }
                
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct PlantDetailView_Previews: PreviewProvider {
    @State static var plant = previewPlant
    
    static var previews: some View {
        PlantDetailView(plant: plant)
    }
}





