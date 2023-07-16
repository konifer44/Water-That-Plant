//
//  DetailTopBarView.swift
//  WaterThatPlant
//
//  Created by Jan Konieczny on 27.07.22.
//

import SwiftUI

struct DetailTopBar: View {
    @State var plant: Plant
    var topPadding: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .center) {
                Image("fikus")
                    .resizable()
                    .frame(width: geometry.size.width / 2)
                    .aspectRatio(1, contentMode: .fill)
                    .clipped()
               Spacer()
                VStack(alignment: .leading, spacing: 15){
                    VStack(alignment: .leading, spacing: 10){
                        Text("Room temp")
                            .foregroundColor(.gray)
                        
                        HStack(spacing: 5){
                            Image(systemName: "thermometer")
                                .foregroundColor(.oliveGreen)
                                .padding(.trailing, 3)
                            Text("\(plant.recommendedTemperature)")
                            Text("°C")
                                .foregroundColor(.gray)
                        }
                        .padding(.leading, 4)
                    }
                    
                    VStack(alignment: .leading, spacing: 10){
                        Text("Light")
                            .foregroundColor(.gray)
                        HStack(spacing: 5){
                            Image(systemName: "sun.max")
                                .foregroundColor(.oliveGreen)
                            Text("\(plant.recommendedLighting.range.upperBound)")
                            Text("%")
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                }
            }
            
            .background(
                Rectangle().fill(Color.grayGradient)
            )
            .cornerRadius(90, corners: .bottomLeft)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct DetailTopBarView_Previews: PreviewProvider {
    
    static var previews: some View {
        DetailTopBar(plant: previewPlant, topPadding: 40)
            .frame(height: 100)
    }
}
