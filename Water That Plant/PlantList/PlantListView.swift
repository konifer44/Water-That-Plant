//
//  ContentView.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 03.06.23.
//

import SwiftUI
import CoreData

struct PlantListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var plants: FetchedResults<Plant>
    @ObservedObject private var viewModel: PlantListViewModel
    @State private var presentedPlantPath = [Plant]()
    @State private var searchText = ""
    private let plantListTopBarHeight: CGFloat = 230
    private let plantListTileHeight: CGFloat = 100
    private let plantTileHeight: CGFloat = 150
    
    init(viewModel: PlantListViewModel){
        self.viewModel = viewModel
    }
    
    
    
    var body: some View {
        NavigationStack(path: $presentedPlantPath) {
            ZStack{
                ScrollView {
                    VStack(spacing: 0) {
                        Spacer(minLength: 10 + plantListTopBarHeight + plantTileHeight / 2)
                        ForEach(plants, id: \.self) { plant in
                            NavigationLink(value: plant) {
                                PlantListTileView(plant: plant)
                                    .frame(height: plantListTileHeight)
                                    .padding()
                                
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                
                
                
                VStack {
                    VStack {
                        PlantListTopBar(action: addPlant, blurredBackgroundHeight: plantTileHeight / 2)
                            .frame(height: plantListTopBarHeight)
                    }
                    
                    ScrollView(.horizontal) {
                        HStack{
                            ForEach(plants, id: \.self) { plant in
                                PlantTile(plant: plant)
                                    .frame(height: plantTileHeight)
                            }
                        }
                        .padding(.leading, 20)
                    }
                    
                    .offset(y: -plantTileHeight / 2)
                    Spacer()
                }
              
            }
            .navigationDestination(for: Plant.self) { plant in
                PlantView(viewModel: PlantViewModel(plant: plant, moc: moc))
            }
        }
    }
    
    
    
    fileprivate func delete(at offsets: IndexSet) {
        for offset in offsets {
            let plant = plants[offset]
            moc.delete(plant)
        }
        try? moc.save()
    }
    
    fileprivate func addPlant() {
        viewModel.addNewPlant { plant, message in
            if let plant {
                presentedPlantPath.append(plant)
            }
        }
    }
}

struct PlantListView_Previews: PreviewProvider {
    static let context = PersistenceController.previewList.container.viewContext
    static var previews: some View {
        
        PlantListView(viewModel: PlantListViewModel(moc: context))
            .environment(\.managedObjectContext, context)
    }
}
