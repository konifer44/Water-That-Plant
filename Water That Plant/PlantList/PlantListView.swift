//
//  ContentView.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 03.06.23.
//

import SwiftUI
import UIKit.UIBlurEffect

import CoreData

struct PlantListView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject private var viewModel: PlantListViewModel
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.nameRawValue)
        ]
    ) var plants: FetchedResults<Plant>
    
    @State var sortDescriptor: SortDescriptors = .name
    @State var presentingAddPlantView: Bool = false
   
    @State var longPressedPlant: Plant?
    
    private let plantListTopBarHeight: CGFloat = 330
    private let plantListTileHeight: CGFloat = 100
    private let plantTileHeight: CGFloat = 150
    
  
    init(viewModel: PlantListViewModel){
        self.viewModel = viewModel
    }
    
    
    var body: some View {
        NavigationStack(path: $viewModel.presentedPlantPath) {
            ZStack(alignment: .top) {
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(plants, id: \.self) { plant in
                            NavigationLink(value: plant) {
                                PlantListTileView(plant: plant)
                                    .frame(height: plantListTileHeight)
                                    .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                                   
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.bottom, plantListTopBarHeight + 20)
                    .offset(y: plantListTopBarHeight + 10)
                }
                
                
                
                PlantListTopBar(addAction: viewModel.addNewPlant, sortAction: viewModel.sortAction, sortDescriptor: $sortDescriptor)
                    .frame(height: plantListTopBarHeight)
                
            }
            .navigationDestination(for: Plant.self) { plant in
                PlantDetailView(plant: plant)
                //PlantView(viewModel: PlantViewModel(plant: plant, moc: moc))
            }
            .edgesIgnoringSafeArea(.all)
        }
        .onChange(of: sortDescriptor) { newValue in
            let newSortDescriptor = newValue.descriptor()
            plants.sortDescriptors = [newSortDescriptor]
        }
        
        .sheet(isPresented: $presentingAddPlantView) {
            if let longPressedPlant {
                AddPlantView(viewModel: AddPlantViewModel(moc: moc, plant: longPressedPlant))
            }
        }
    }
    
    func longTapped(plant: Plant) {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        longPressedPlant = plant
        presentingAddPlantView = true
    }
    
    private func sort(){
        plants.sortDescriptors = [sortDescriptor.descriptor()]
    }
}

struct PlantListView_Previews: PreviewProvider {
    static let context = PersistenceController.previewList.container.viewContext
    static var previews: some View {
        
        PlantListView(viewModel: PlantListViewModel(moc: context))
            .environment(\.managedObjectContext, context)
    }
}
