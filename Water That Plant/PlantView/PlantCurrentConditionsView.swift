//
//  CurrentPlantConditionsView.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 17.03.23.
//

import Foundation
import SwiftUI

struct PlantCurrentConditionsView: View {
   @State var plant: Plant
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack {
                Image(systemName: "chart.line.uptrend.xyaxis")
                Text("CURRENT PLANT CONDITIONS")
                Spacer()
            }
            .font(.body)
            .foregroundColor(.gray)
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 0))
            
            HStack{
                Spacer()
                ProgressBar(progress: plant.currentSoilHumidity, color: .blue, title: "Humidity", icon: "humidity")
                    .frame(height: 130)
                Spacer()
                ProgressBar(progress: plant.currentFertilizer, color: .brown, title: "Fertilizer", icon: "leaf.arrow.triangle.circlepath")
                    .frame(height: 130)
                Spacer()
                ProgressBar(progress: plant.currentLighting, color: .orange, title: "Light", icon: "sun.max")
                    .frame(height: 130)
                Spacer()
            }
            Spacer()
        }
        //.background(Color.red)
        .frame(maxHeight: 200)
    }
}


struct PlantCurrentConditionsView_Previews: PreviewProvider {
    static let context = PersistenceController.previewPlant.container.viewContext
    static var previews: some View {
       
        PlantCurrentConditionsView(plant: previewPlant)
            .environment(\.managedObjectContext, context)
    }
}


var previewPlant: Plant = {
    let context = PersistenceController.previewPlant.container.viewContext
    var plant = Plant(context: context)
    plant.name = "Plant"
    plant.selectedRoom = .bathroom
    plant.currentSoilHumidity = 21.37
    plant.currentLighting = 2
    plant.currentFertilizer = 79
    return plant
}()
