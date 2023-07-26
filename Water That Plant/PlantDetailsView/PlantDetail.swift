//
//  PlantDetail.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 24.07.23.
//

import SwiftUI

struct PlantDetail: View {
    @State var plant: Plant
    @State var height: CGFloat
    
    let gradient = LinearGradient(
            gradient: Gradient(stops: [
                .init(color: .gray, location: 0),
                .init(color: .clear, location: 0.8)
            ]),
            startPoint: .bottom,
            endPoint: .top
        )
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                Image("fikus")
                    .resizable()
                    
                    //.aspectRatio(contentMode: .fill)
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: height)
                    .clipped()
                
                
                Rectangle()
                    .fill(.gray)
                    .frame(height: height / 2)
                    .mask(gradient) /// mask the blurred image using the gradient's alpha values
                
             
                
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text("Classroom of the Elite")
                            .font(.title2)
                            .bold()
                        Text("Horikita best girl")
                            .font(.headline)
                            .bold()
                    }
                    
                    .padding()
                   
                    Spacer()
                    
                    TemperatureAndLightCard(plant: plant)
                        .padding()
                }
                
                .foregroundColor(.white)
            }
            
            .ignoresSafeArea(.all)
        }
    }
    
}

struct PlantDetail_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            PlantDetail(plant: previewPlant, height: geo.size.height / 2.5)
                
        }
    }
}




private struct TemperatureAndLightCard: View {
    @State var plant: Plant
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            VStack(alignment: .leading, spacing: 10){
                Text("Room temp")
                    .foregroundColor(.gray)
                
                HStack{
                    Image(systemName: "thermometer")
                        .foregroundColor(.oliveGreen)
                        .padding(.trailing, 3)
                    Text("\(plant.recommendedTemperature) °C")
                }
                .padding(.leading, 4)
            }
            .foregroundColor(.gray)
            
            
            VStack(alignment: .leading, spacing: 10){
                Text("Light")
                    .foregroundColor(.gray)
                HStack(spacing: 5){
                    Image(systemName: "sun.max")
                        .foregroundColor(.oliveGreen)
                    Text("\(plant.recommendedLighting.range.lowerBound) °C")
                }
            }
            .foregroundColor(.gray)
            
            
        }
        .padding()
        .background(Color(uiColor: UIColor.systemGray5))
        .cornerRadius(20)
    }
}
