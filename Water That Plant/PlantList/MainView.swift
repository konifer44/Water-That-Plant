//
//  MainView.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 14.10.23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack{
            TabView{
                List(){
                    
                }
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
                
                List(){
                    
                }
                .tabItem {
                    Label("Order", systemImage: "square.and.pencil")
                }
            }
        }
    }
}

#Preview {
    MainView()
}


