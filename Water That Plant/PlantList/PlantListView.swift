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
        sortDescriptors: [SortDescriptor(\.nameRawValue)]
    )
    var plants: FetchedResults<Plant>
    
    private let plantListTopBarHeight: CGFloat = 330
    private let plantListTileHeight: CGFloat = 100
    private let plantTileHeight: CGFloat = 150
    
    init(viewModel: PlantListViewModel){
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            TabView {
                ZStack(alignment: .top) {
                    
                    List(plants) { plant in
                        Spacer(minLength: plantTileHeight)
                        
                        NavigationLink {
                            PlantDetailView(plant: plant)
                        } label: {
                            PlantListTileView(plant: plant)
                        }
                        .swipeActions {
                            editAction
                        }
                        
                        // .onDelete(perform: deleteAction)
                        
                    }
                    .offset(y: plantTileHeight)
                    .listStyle(.plain)
                    .tabItem {
                                       Label("Menu", systemImage: "list.dash")
                                   }
                    PlantListTopBar(addPlantViewModel: $viewModel.addPlantViewModel,
                                    sortDescriptor: $viewModel.sortDescriptor)
                    .frame(height: plantListTopBarHeight)
                    
                }
                
                .edgesIgnoringSafeArea(.all)
                .tabItem {
                                    Label("Alerts", systemImage: "list.dash")
                                }
            }
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
        PlantListView(viewModel: PlantListViewModel(viewContext: CoreDataManager.previewList.viewContext))
            .environment(\.managedObjectContext, CoreDataManager.previewList.viewContext)
    }
}
