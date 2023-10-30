import Foundation
import SwiftUI

extension View {
    func getScrollOffset(_ geometry: GeometryProxy) -> CGFloat {
        geometry.frame(in: .global).minY
    }
    
    
    func getOffsetForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geometry)
        
        if offset > 0 {
            return -offset
        }
        
        return 0
    }
    
    
    
    
    
    func gradientBackground() -> some View {
        modifier(GradientBackground())
    }
}

var gradientBackgroundColor: some View {
    ZStack {
        LinearGradient(
            colors: [
                Color.red.opacity(0.4),
                Color.green.opacity(0.4),
                Color.white],
            startPoint: .topTrailing,
            endPoint: .center
        )
        
        
        LinearGradient(
            colors: [
                Color.purple,
                Color.green.opacity(0.5),
                Color.red.opacity(0.1),
                Color.white],
            
            startPoint: .top,
            endPoint: .bottomTrailing
        )
        
        LinearGradient(
            colors: [
                Color.orange.opacity(0.1),
                Color.green.opacity(0.1)],
            
            startPoint: .bottomLeading,
            endPoint: .topTrailing
        )
    }
}


struct GradientBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                gradientBackgroundColor
                    .ignoresSafeArea(.all)
            )
    }
}
