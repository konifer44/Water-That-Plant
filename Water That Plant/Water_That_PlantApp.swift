//
//  Water_That_PlantApp.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 03.06.23.
//

import SwiftUI

@main
struct Water_That_PlantApp: App {
    @StateObject private var persistenceController = PersistenceController()

    var body: some Scene {
        WindowGroup {
            PlantListView(viewModel: PlantListViewModel(moc: persistenceController.container.viewContext))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
