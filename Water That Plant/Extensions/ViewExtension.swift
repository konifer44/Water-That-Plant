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
}
