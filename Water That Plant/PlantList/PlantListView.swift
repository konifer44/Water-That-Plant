//
//  ContentView.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 03.06.23.
//

import SwiftUI


import CoreData

struct PlantListView: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject private var viewModel: PlantListViewModel
    @State var presentingAddPlantView: Bool = false
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.nameRawValue)
        ]
    ) var plants: FetchedResults<Plant>
    
    private let plantListTopBarHeight: CGFloat = 330
    private let plantListTileHeight: CGFloat = 100
    private let plantTileHeight: CGFloat = 150
    
    init(viewModel: PlantListViewModel){
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                List {
                    Spacer(minLength: plantTileHeight)
                    ForEach(plants, id: \.self) { plant in
                        NavigationLink(value: plant) {
                            PlantListTileView(plant: plant)
                                .frame(height: plantListTileHeight)
                                .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                        }
                        .swipeActions {
                          editAction
                        }
                    }
                    .onDelete(perform: deleteAction)
                    
                }
                .offset(y: plantTileHeight)
                .listStyle(.plain)
                
                PlantListTopBar(addPlantViewModel: $viewModel.addPlantViewModel,
                                sortDescriptor: $viewModel.sortDescriptor)
                .frame(height: plantListTopBarHeight)
                
            }
            .navigationDestination(for: Plant.self) { plant in
                PlantDetailView(plant: plant)
            }
            .edgesIgnoringSafeArea(.all)
        }
        .onChange(of: viewModel.sortDescriptor) { newSortDescriptor in
            setSortDescriptor(for: newSortDescriptor)
        }
        
        .sheet(item: $viewModel.addPlantViewModel) { viewModel in
            AddPlantView(viewModel: viewModel)
        }
    }
    
    
    
    private func setSortDescriptor(for newSortDescriptor: SortDescriptors){
        let newSortDescriptor = newSortDescriptor.descriptor()
        plants.sortDescriptors = [newSortDescriptor]
    }
    
    var editAction: some View {
        Button("Edit") {
            print("Awesome!")
        }
        .tint(.blue)
    }
    
    func deleteAction(at offsets: IndexSet) {
        for offset in offsets {
            let plant = plants[offset]
            viewContext.delete(plant)
        }
        try? viewContext.save()
    }
}





//MARK: - Previews
struct PlantListView_Previews: PreviewProvider {
    static var previews: some View {
        PlantListView(viewModel: PlantListViewModel(viewContext: CoreDataManager.shared.viewContext))
            .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
    }
}
