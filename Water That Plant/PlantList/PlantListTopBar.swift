//
//  PlantListTopBar.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 06.07.23.
//

import SwiftUI
import UIKit

struct PlantListTopBar: View {
    var action: () -> Void
    let blurStyle: UIBlurEffect.Style
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                VStack{
                    Spacer()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Hi Jan!")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Text("Browse trough your plants")
                        }
                        .foregroundColor(.white)
                        .padding(30)
                        
                        Spacer()
                        Button {
                            action()
                        } label: {
                            Image(systemName: "plus.square.fill")
                                .foregroundStyle(Color.oliveGreen, .yellow)
                                .font(.system(size: 50))
                        }
                        .shadow(radius: 10)
                        .padding(30)
                    }
                    .padding(.bottom, 30)
                    Spacer()
                }
                .background(
                    VStack {
                        Rectangle()
                            .fill(Color.oliveGreenGradient)
                            .background(Color.white)
                            .cornerRadius(90, corners: .bottomLeft)
                        
                        
                        HStack {
                            Label("Your plants", systemImage: "leaf")
                                .padding(.leading, 20)
                            Spacer()
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .padding(.trailing, 20)
                        }
                        .font(.title3)
                        .foregroundColor(.oliveGreen)
                        
                        
                    }
                        .background(.clear)
                        .edgesIgnoringSafeArea(.all)
                )
            }
            .background(BlurView(style: blurStyle))
            
        }
        
    }
}


struct PlantListTopBar_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                PlantListTopBar(action: { }, blurStyle: .light)
                    .frame(height: geo.size.height / 3)
                Divider()
            }
        }
        
    }
}



struct BlurView : UIViewRepresentable {
    
    var style : UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}
