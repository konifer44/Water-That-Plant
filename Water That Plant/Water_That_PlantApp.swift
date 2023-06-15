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
 //   @StateObject var bleManager = BLEManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
              //  .environmentObject(bleManager)
        }
    }
}
