//
//  PlantListTopBar.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 06.07.23.
//

//
//  MainTopBar.swift
//  WaterThatPlant
//
//  Created by Jan Konieczny on 27.07.22.
//

import SwiftUI

struct PlantListTopBar: View {
    var action: () -> Void
    let blurredBackgroundHeight: CGFloat
    
    var body: some View {
        
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
                .padding(30)
            }
            
            Spacer()
        }
        .background(
            Rectangle()
                .fill(Color.oliveGreenGradient)
                .background(Color.white)
                .cornerRadius(90, corners: .bottomLeft)
                .edgesIgnoringSafeArea(.all)
        )
        .background(BlurView(style: .regular))
    }
}


struct PlantListTopBar_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            PlantListTopBar(action: { }, blurredBackgroundHeight: 100)
                .frame(height: geo.size.height / 4)
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
