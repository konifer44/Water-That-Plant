//
//  MainView.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 14.10.23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            NavigationStack {
                PlantList()
                    .environment(\.managedObjectContext, CoreDataManager.previewList.viewContext)
                
            }
            .tabItem {
                Label("Plants", systemImage: "leaf")
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

#Preview {
    MainView()
}


