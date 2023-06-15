//
//  Humidity Sensor Model.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 13.03.23.
//

import Foundation
import CoreBluetooth

struct SensorModel: Equatable, Hashable {
    let id = UUID()
    let peripheral: CBPeripheral
    var isConnected: Bool
    
    static func ==(lhs: SensorModel, rhs: SensorModel) -> Bool {
        return lhs.id == rhs.id && lhs.id == rhs.id
    }
}
