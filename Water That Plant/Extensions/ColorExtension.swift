//
//  ColorExtansion.swift
//  WaterThatPlant
//
//  Created by Jan Konieczny on 27.07.22.
//

import Foundation
import SwiftUI

extension Color {
    static let grayGradient = LinearGradient(colors: [Color(uiColor: .systemGray5), Color(uiColor: .systemGray6)], startPoint: .bottomLeading, endPoint: .topTrailing)
    static let oliveGreenGradient = LinearGradient(colors: [Color.oliveGreen, Color.oliveGreenBright], startPoint: .bottomLeading, endPoint: .topTrailing)
    static let brownOliveGreenGradient = LinearGradient(colors: [.brown, Color("flora")], startPoint: .bottomLeading, endPoint: .topTrailing)
    static let blueOliveGreenGradient = LinearGradient(colors: [.blue, Color.oliveGreen], startPoint: .bottomLeading, endPoint: .topTrailing)
    static let oliveGreen = Color(red: 50/255, green: 168/255, blue: 117/255, opacity: 100)
    static let oliveGreenBright = Color(red: 118/255, green: 204/255, blue: 167/255, opacity: 100)
}
