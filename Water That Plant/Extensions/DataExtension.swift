//
//  ImageExtension.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 12.07.23.
//

import Foundation
import UIKit
import SwiftUI

extension Data {
    
    func fromData() -> Image {
        if let uiImage = UIImage(data: self) {
            let image = Image(uiImage: uiImage)
            return image
        } else {
            return Image(uiImage: UIImage())
        }
    }
}
