//
//  PlantListTileView.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 20.06.23.
//

import SwiftUI

struct PlantListTileView: View {
    @ObservedObject var plant: Plant
    var body: some View {
        HStack(spacing: 10){
            
            Image(uiImage: plant.image)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .cornerRadius(15)
            
            
                .padding(EdgeInsets(top: 13, leading: 13, bottom: 13, trailing: 0))
            
            
            VStack(alignment: .leading, spacing: 8){
                HStack{
                    Text(plant.name)
                        .font(.title2)
                        .foregroundColor(.oliveGreen)
                        .bold()
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
                .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 10))
                Divider()
                    .padding(.trailing, 30)
                
                
                VStack(alignment: .leading) {
                    Label {
                        Text("Recommendations")
                    } icon: {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundStyle(.orange)
                    }
                    
                    Group {
                        Text("• 150ml water")
                        Text("• 30ml fertilizer")
                    }
                    .padding(.leading, 22)
                    
                }
                .font(.caption)
                .foregroundStyle(.secondary)
                Spacer()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(15)
    }
}

struct PlantListTileView_Previews: PreviewProvider {
    let plant = previewPlant
    static var previews: some View {
        
        VStack {
            Spacer()
            PlantListTileView(plant: previewPlant)
                .frame(height: 140)
                .padding()
            Spacer()
        }
        .gradientBackground()
        // .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        // .shadow(color: .gray.opacity(0.5), radius: 5)
        //  .padding()
        
    }
}
