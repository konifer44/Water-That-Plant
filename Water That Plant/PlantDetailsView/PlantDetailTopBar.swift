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
                
                
            }
        }
        .frame(maxWidth: .infinity)
        .background(
            VStack(spacing: 0) {
                Image("fikus")
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(90, corners: .bottomLeft)
                
                
              
                Divider()
                    .background(Color.oliveGreen)
            }
                .background(.clear)
                .edgesIgnoringSafeArea(.all)
        )
        .shadow(radius: 10)
        .edgesIgnoringSafeArea(.all)
    }
}

struct DetailTopBarView_Previews: PreviewProvider {
    
    static var previews: some View {
        GeometryReader{ geometry in
            VStack {
                DetailTopBar(plant: previewPlant)
                    .frame(height: geometry.size.height / 6)
                Spacer()
            }
        }
    }
}
