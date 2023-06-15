//
//  ContentView.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 03.06.23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @FetchRequest(sortDescriptors: []) var plants: FetchedResults<Plant>
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationStack {
            List(plants, id: \.self) { plant in
                NavigationLink(plant.name ?? ""){
                   PlantView(plant: plant)
                }
            }
            .navigationTitle("Plants")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        let plant = Plant(context: moc)
                        plant.name = "Kaktus"
                        plant.selectedRoom = .bathroom
                        plant.currentSoilHumidity = 21.37
                        plant.currentLighting = 2
                        plant.currentFertilizer = 79
                        try? moc.save()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let context = PersistenceController.previewList.container.viewContext
    static var previews: some View {
        
        ContentView()
            .environment(\.managedObjectContext, context)
    }
}
