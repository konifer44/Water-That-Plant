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
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.nameRawValue)
        ]
    ) var plants: FetchedResults<Plant>
    
    @State var sortDescriptor: SortDescriptors = .name
    @State var presentingAddPlantView: Bool = false
  
    private let plantListTopBarHeight: CGFloat = 330
    private let plantListTileHeight: CGFloat = 100
    private let plantTileHeight: CGFloat = 150
    
    init(viewModel: PlantListViewModel){
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack(path: $viewModel.presentedPlantPath) {
            ZStack(alignment: .top) {
                List {
                    //VStack(spacing: 0) {
                        ForEach(plants, id: \.self) { plant in
                            NavigationLink(value: plant) {
                                PlantListTileView(plant: plant)
                                    .frame(height: plantListTileHeight)
                                    .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                                   
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .onDelete(perform: delete)
                   // }
                    .padding(.bottom, plantListTopBarHeight + 20)
                    .offset(y: plantListTopBarHeight + 10)
                }
                .listStyle(.plain)
            
                PlantListTopBar(addPlant: $presentingAddPlantView, sortAction: viewModel.sortAction, sortDescriptor: $sortDescriptor)
                    .frame(height: plantListTopBarHeight)
                
            }
            .navigationDestination(for: Plant.self) { plant in
                PlantDetailView(plant: plant)
            }
            .edgesIgnoringSafeArea(.all)
        }
        .onChange(of: sortDescriptor) { newValue in
            let newSortDescriptor = newValue.descriptor()
            plants.sortDescriptors = [newSortDescriptor]
        }
        
        .sheet(isPresented: $presentingAddPlantView) {
            AddPlantView(viewModel: AddPlantViewModel(viewContext: viewContext))
        }
    }
    
    func delete(at offsets: IndexSet) {
       for offset in offsets {
           let plant = plants[offset]
           viewContext.delete(plant)
       }
       try? viewContext.save()
   }
    
    private func sort(){
        plants.sortDescriptors = [sortDescriptor.descriptor()]
    }
}

struct PlantListView_Previews: PreviewProvider {
    static var previews: some View {
        PlantListView(viewModel: PlantListViewModel(viewContext: CoreDataManager.shared.viewContext))
            .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
    }
}
