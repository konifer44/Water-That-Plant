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
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.nameRawValue)
        ]
    ) var plants: FetchedResults<Plant>
    @ObservedObject private var viewModel: PlantListViewModel
    
    var sortDescriptors: [NSSortDescriptor] = []
    
    private let plantListTopBarHeight: CGFloat = 300
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
                    .offset(y: plantListTopBarHeight + 10)
                }
                
                
                VStack(spacing: 0) {
                    PlantListTopBar(action: viewModel.addNewPlant, blurStyle: .light)
                        .frame(height: plantListTopBarHeight)
                    Divider()
                        .background(Color.oliveGreen)
                }
            }
            .navigationDestination(for: Plant.self) { plant in
                PlantView(viewModel: PlantViewModel(plant: plant, moc: moc))
            }
            .edgesIgnoringSafeArea(.all)
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
