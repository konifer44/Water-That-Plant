//
//  TextFieldClearButtonModifier.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 14.03.23.
//

import Foundation
import SwiftUI


struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        HStack {
            content
            
            if !text.isEmpty {
                Button(
                    action: { self.text = "" },
                    label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                )
            }
        }
    }
}
