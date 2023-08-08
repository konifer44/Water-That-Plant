//
//  PlantDetailView.swift
//  WaterThatPlant
//
//  Created by Jan Konieczny on 25.07.22.
//

import SwiftUI


struct PlantDetailView: View {
    @State var plant: Plant
    @State private var isShowingEditPlantView: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0){
                PlantDetailTopBar(plant: plant, height: geometry.size.height / 2.5)
                    .frame(height: geometry.size.height / 2.5)
                ScrollView {
                    VStack(alignment: .leading){
                        Spacer(minLength: 20)
                        HStack{
                            Image(systemName: "chart.bar.xaxis")
                                .foregroundColor(.oliveGreen)
                                .font(.title2)
                            Text("Plant stats")
                                .font(.title3)
                            Spacer()
                        }
                        .padding()
                        PlantStatsTile(plant: plant, type: .hydration)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                        
                        PlantStatsTile(plant: plant, type: .fertilizer)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                        
                        PlantStatistics()
                            .padding()
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .toolbar {
            Button {
                isShowingEditPlantView = true
            } label: {
                Text("Edit")
            }

        }
        .sheet(isPresented: $isShowingEditPlantView) {
            let viewModel = AddPlantViewModel(editPlant: plant)
            
            let view = AddPlantView(viewModel: viewModel)
            view
        }
    }
}

struct PlantDetailView_Previews: PreviewProvider {
    @State static var plant = previewPlant
    
    static var previews: some View {
        NavigationStack {
            PlantDetailView(plant: plant)
        }
    }
}





