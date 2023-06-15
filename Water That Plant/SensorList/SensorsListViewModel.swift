//
//  SensorsListViewModel.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 07.05.23.
//

import Foundation
import SwiftUI
import CoreBluetooth
import Combine

class SensorsListViewModel: ObservableObject {
    @FetchRequest(sortDescriptors: []) var plants: FetchedResults<Plant>
    @Published var bleManager = BLEManager.shared
   
    private var anyCancellable: AnyCancellable? = nil

        init() {
            anyCancellable = bleManager.objectWillChange.sink { [weak self] _ in
                self?.objectWillChange.send()
            }
        }
    
    private var plantSensorCBService = CBUUID(string: "4FAFC201-1FB5-459E-8FCC-C5C9C331914B")
   
    
    func startScanningForPeripherals(){
        bleManager.startScanningForPeripherals(cbuuid: plantSensorCBService, clearList: true)
    }
    
    func stopScanningForPeripherals(){
        bleManager.stopScanningForPeripherals()
    }
    
    func connectToPeripheral(with uuid: UUID){
        bleManager.connectToPeripheral(with: uuid)
    }
    
    func isConnected(uuid: UUID) -> Bool {
        
        return false
    }
}
