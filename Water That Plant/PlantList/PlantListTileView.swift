//
//  PlantListTileView.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 20.06.23.
//

import SwiftUI

struct PlantListTileView: View {
    @State var plant: Plant
    var body: some View {
        HStack{
            Image("fikus")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .cornerRadius(25)
                .padding(10)
                
            VStack(alignment: .leading){
                Text(plant.name)
                    .font(.title2)
                    .bold()
                   // .foregroundColor(.oliveGreen)
                Text("This plant need water (150ml)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
           
            Spacer()
        }
        .background(Color(uiColor: .systemGray6))
    
        .cornerRadius(25)
        .shadow(color: .gray.opacity(0.5), radius: 5)
    }
}

struct PlantListTileView_Previews: PreviewProvider {
    let plant = previewPlant
    static var previews: some View {
        
        PlantListTileView(plant: previewPlant)
            .frame(maxWidth: .infinity, maxHeight: 140)
           // .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
           // .shadow(color: .gray.opacity(0.5), radius: 5)
          //  .padding()
        
    }
}
