//
//  ProgressBarView.swift
//  WaterThatPlant
//
//  Created by Jan Konieczny on 23.01.22.
//

import Foundation
import SwiftUI

struct ProgressBar: View {
    @State var progress: Double
    var color: Color
    var title: String = ""
    var icon: String = ""
    var lineWidth: CGFloat = 10
    
    var body: some View {
        VStack(spacing: 15){
            GeometryReader { geometry in
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .padding(-(lineWidth/2) - 3)
                   
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: lineWidth - 1, lineCap: .round, lineJoin: .round))
                        .foregroundColor(.gray.opacity(0.1))
                        .rotationEffect(Angle(degrees: 90))
                    
                    Circle()
                        .trim(from: 0, to: CGFloat(min(progress / 100, 1.0)))
                        .stroke(style: StrokeStyle(lineWidth: lineWidth - 1, lineCap: .round, lineJoin: .round))
                        .foregroundColor(color.opacity(0.5))
                        .rotationEffect(Angle(degrees: 90))
                    
                    Circle()
                        .strokeBorder(color,lineWidth: 2)
                        .background(Circle().foregroundColor(color.opacity(0.9)))
                        .frame(width: lineWidth + 2)
                        .offset(y:  geometry.size.width / 2)
                        .rotationEffect(.degrees(progress/100 * 360))
                        .foregroundColor(color.opacity(0.5))
                    
                }
              
                .animation(.easeInOut, value: progress)
                .overlay {
                    VStack(spacing: 3) {
                        Image(systemName: icon)
                        Text("\(Int(progress))%")
                            .bold()
                    }
                    .font(.system(size: geometry.size.width / 5))
                    .minimumScaleFactor(0.01)
                }
                .foregroundColor(color)
            }
            .aspectRatio(1, contentMode: .fit)
            .padding(lineWidth / 2)
         //   Text(title)
           //     .font(.body)
            //    .foregroundColor(.gray)
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(progress: 90.0, color: .blue, title: "Preview", icon: "cloud")
            .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
            .previewLayout(.sizeThatFits)
            //.padding()
    }
}


