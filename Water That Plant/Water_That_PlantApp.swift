//
//  Water_That_PlantApp.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 03.06.23.
//

import SwiftUI

@main
struct Water_That_PlantApp: App {
    var body: some Scene {
        WindowGroup {
            let viewContext = CoreDataManager.shared.viewContext
            PlantListView(viewModel: PlantListViewModel(viewContext: viewContext))
                .environment(\.managedObjectContext, viewContext)
        }
    }
}
