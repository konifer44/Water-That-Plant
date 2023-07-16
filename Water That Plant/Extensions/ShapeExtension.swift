//
//  ShapeExtension.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 06.07.23.
//

import Foundation
//
//  ShapeExtansion.swift
//  WaterThatPlant
//
//  Created by Jan Konieczny on 17.07.22.
//

import Foundation
import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}


struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
