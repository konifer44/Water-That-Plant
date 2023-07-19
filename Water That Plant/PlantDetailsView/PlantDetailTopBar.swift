//
//  DetailTopBarView.swift
//  WaterThatPlant
//
//  Created by Jan Konieczny on 27.07.22.
//

import SwiftUI

struct DetailTopBar: View {
    @State var plant: Plant
    
    
    var body: some View {
        
        VStack{
            Spacer()
            HStack {
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
                  
                    
                }
                .padding()
                .background(Color(uiColor: UIColor.systemGray5))
                .cornerRadius(20)
                .padding()
                
            }
        }
        .frame(maxWidth: .infinity)
        .background(
            VStack(spacing: 0) {
                Image("fikus")
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(90, corners: .bottomLeft)
                
                
                HStack {
                    Label("Your plants", systemImage: "leaf")
                    Spacer()
                   
                    
                }
                .padding(15)
                .font(.title3)
                .foregroundColor(.oliveGreen)
                
                Divider()
                    .background(Color.oliveGreen)
            }
                .background(.clear)
                .edgesIgnoringSafeArea(.all)
        )
   // }
    //.background(BlurView(style: .light))
        
       // .cornerRadius(90, corners: .bottomLeft)
        .shadow(radius: 10)
        .edgesIgnoringSafeArea(.all)
    }
}

struct DetailTopBarView_Previews: PreviewProvider {
    
    static var previews: some View {
        GeometryReader{ geometry in
            VStack {
                DetailTopBar(plant: previewPlant)
                    .frame(height: geometry.size.height / 3)
                Spacer()
            }
        }
    }
}
