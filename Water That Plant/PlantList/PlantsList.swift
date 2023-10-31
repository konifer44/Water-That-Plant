//
//  AlertsList.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 03.06.23.
//

import SwiftUI


import CoreData

struct PlantList: View {
    @ObservedObject private var viewModel: PlantListViewModel
    @State var presentingAddPlantView: Bool = false
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.nameRawValue)]
    )
    var plants: FetchedResults<Plant>
    let viewContext = CoreDataManager.shared.viewContext
    
    init(viewModel: PlantListViewModel = PlantListViewModel()){
        self.viewModel = viewModel
    }
    
    @State private var showRecentAlertsSection: Bool = true
    var body: some View {
            ScrollView {
                Divider()
                HStack {
                    Text("Most recent alerts")
                        .font(.headline)
                    Spacer()
                    Button{
                        withAnimation {
                            showRecentAlertsSection.toggle()
                        }
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.white, Color.oliveGreen)
                    }
                   
                }
                .padding(EdgeInsets(top: 7, leading: 17, bottom: 7, trailing: 20))
                if showRecentAlertsSection {
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(plants) { plant in
                                NavigationLink {
                                    PlantDetailView(plant: plant)
                                } label: {
                                    PlantListTileView(plant: plant)
                                    
                                }
                                
                                .frame(width: 350, height: 150)
                                .padding(EdgeInsets(top: 7, leading: 7, bottom: 7, trailing: 7))
                                .buttonStyle(.plain)
                                .swipeActions {
                                    editAction
                                }
                            }
                        }
                    }
                    //.contentMargins(.bottom, 7, for: .scrollContent)
                    .contentMargins([.leading, .bottom], 7, for: .scrollContent)
                }
                Divider()
                HStack {
                    Text("All plants")
                        .font(.headline)
                    Spacer()
                    Menu {
                        Text("Sort by:")
                        Picker("Sort", selection: $viewModel.sortDescriptor, content: {
                            
                            ForEach(SortDescriptors.allCases, id: \.self){
                                Text($0.rawValue).tag($0)
                            }
                        })
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            .foregroundStyle(.white, Color.oliveGreen)
                    }
                }
                .padding(EdgeInsets(top: 7, leading: 17, bottom: 7, trailing: 20))
                    
                ForEach(plants) { plant in
                    NavigationLink {
                        PlantDetailView(plant: plant)
                    } label: {
                        PlantListTileView(plant: plant)
                        
                    }
                    
                    .frame(height: 110)
                    .padding(EdgeInsets(top: 7, leading: 17, bottom: 7, trailing: 17))
                    .buttonStyle(.plain)
                    .swipeActions {
                        editAction
                    }
                }
                
                .listStyle(.plain)
                .onChange(of: viewModel.sortDescriptor) { oldSortDescriptor, newSortDescriptor in
                    setSortDescriptor(to: newSortDescriptor)
                }
                
                .sheet(item: $viewModel.addPlantViewModel) { viewModel in
                    AddPlantView(viewModel: viewModel)
                }
            }
            
            .navigationTitle("Your plants")
            .edgesIgnoringSafeArea(.bottom)
            .gradientBackground()
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar, .tabBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image("fikus")
                            .resizable()
                            .frame(width: 40, height: 40, alignment: .center)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.3), radius: 5)
                    }

                   
                }
            }
    }
    
   
    
    private func setSortDescriptor(to newSortDescriptor: SortDescriptors){
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
struct AlertsList_Previews: PreviewProvider {
    static var previews: some View {
        TabView{
            NavigationStack {
                PlantList()
                    .environment(\.managedObjectContext, CoreDataManager.previewList.viewContext)
                
            }
            .tabItem {
                    Label("All plants", systemImage: "leaf")
            }
            
            NavigationStack {
                PlantList()
                    .environment(\.managedObjectContext, CoreDataManager.previewList.viewContext)
                
            }
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
        }
    }
}

