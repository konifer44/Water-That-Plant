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
    var title: String
    var icon: String
    
    var body: some View {
        VStack(spacing: 15){
            GeometryReader { geometry in
                ZStack {
                    Circle()
                        .stroke(lineWidth: 10)
                        .opacity(0.3)
                        .foregroundColor(color)
                    
                    Circle()
                        .trim(from: 0.0, to: CGFloat(min(progress / 100, 1.0)))
                        .stroke(style: StrokeStyle(lineWidth: 9, lineCap: .round, lineJoin: .round))
                        .foregroundColor(color.opacity(0.5))
                        .rotationEffect(Angle(degrees: 90))
                    
                    Circle()
                        .strokeBorder(color,lineWidth: 2)
                        .background(Circle().foregroundColor(color.opacity(0.9)))
                        .frame(width: 12, height: 12)
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
            
            Text(title)
                .font(.body)
                .foregroundColor(.gray)
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static let context = PersistenceController.previewPlant.container.viewContext
    static var previews: some View {
        ProgressBar(progress: 21.2, color: .blue, title: "Preview", icon: "cloud")
            .environment(\.managedObjectContext, context)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}


