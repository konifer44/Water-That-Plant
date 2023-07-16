//
//  SwiftUIView.swift
//  WaterThatPlant
//
//  Created by Jan Konieczny on 06.08.22.
//

import SwiftUI

struct CircleIndicator: View {
    @Binding var progress: Double
    let lineWidth: CGFloat = 15
    let color: Color
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white)
                .padding(-(lineWidth/2) - 3)
            
            Circle()
                .stroke(
                    color.gradient.opacity(0.1),
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
    
            Circle()
                .trim(from: 0, to: progress/100)
                .stroke(
                    color.gradient,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(90))
                .animation(.easeOut, value: progress)
   
            HStack(spacing: 5) {
                Text("\((progress).removeZerosFromEnd())")
                Text("%")
                    .foregroundColor(.gray)
            }
            .font(.title2)
            
        }
        .padding(lineWidth/2)
    }
}

struct CircleIndicator_Previews: PreviewProvider {
    static var previews: some View {
        CircleIndicator(progress: .constant(10), color: .blue)
    }
}
