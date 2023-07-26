//
//  BLEManager.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 07.05.23.
//

import Foundation
import CoreBluetooth
import Combine


class BLEManager: NSObject,  ObservableObject{
    @Published var peripheralList: [CBPeripheral] = [] 
     
    private var centralManager: CBCentralManager!
    var connectedPeripheral: CBPeripheral?
    
    static let shared = BLEManager()
    
    override init(){
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func startScanningForPeripherals(cbuuid: CBUUID, clearList: Bool){
        if clearList {
            peripheralList.removeAll()
        }
        
        guard !centralManager.isScanning else { return }
       
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){ [weak self] in
            guard let self = self,
                  self.centralManager.state == .poweredOn else { return }
            
            self.centralManager.scanForPeripherals(withServices: [cbuuid])
        }
    }
    
    func stopScanningForPeripherals(){
        guard centralManager.isScanning else { return }
        centralManager.stopScan()
    }
    
    func connectToPeripheral(peripheral: CBPeripheral){
        centralManager.connect(peripheral)
    }
    
    func connectToPeripheral(with identifier: UUID){
        if let peripheral = centralManager.retrievePeripherals(withIdentifiers: [identifier]).first {
            connectedPeripheral = peripheral
            if let connectedPeripheral {
                centralManager.connect(connectedPeripheral)
            }
           
        } else {
            print("Could not find peripheral")
        }
    }
    
    func disconnectFromPeripheral(peripheral: CBPeripheral){
        centralManager.cancelPeripheralConnection(peripheral)
    }
    
    func retrivePeripherals(with uuid: UUID){
        centralManager.retrievePeripherals(withIdentifiers: [uuid])
    }
    
    func isConnected(uuid: UUID) -> Bool {
        if let peripheral =  centralManager.retrievePeripherals(withIdentifiers: [uuid]).first {
            switch peripheral.state {
            case .connected:
                return true
            case .connecting:
                return true
            case .disconnected:
                return false
            case .disconnecting:
                return false
            @unknown default:
                return false
            }
        } else {
            return false
        }
    }
    
    func addPeripheralToList(peripheral: CBPeripheral){
        if peripheralList.isEmpty {
            peripheralList.append(peripheral)
        } else {
            if peripheralList.filter({ $0 == peripheral }).isEmpty {
                peripheralList.append(peripheral)
            }
        }
    }
}







extension BLEManager: CBCentralManagerDelegate, CBPeripheralDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("poweredOn")
            break
        case .unknown:
            print("unknown")
            break
        case .resetting:
            print("resetting")
            break
        case .unsupported:
            print("unsupported")
            break
        case .unauthorized:
            print("unauthorized")
            break
        case .poweredOff:
            print("poweredOff")
            break
        @unknown default:
            break
        }
    }
    
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        peripheral.delegate = self
        addPeripheralToList(peripheral: peripheral)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        peripheral.discoverServices(nil)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        services.forEach { service in
            peripheral.discoverCharacteristics(nil, for: service)
        }
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let char = service.characteristics?.first {
           // peripheral.readValue(for: char)
            peripheral.setNotifyValue(true, for: char)
        }
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard let data = characteristic.value else { return }
        print(data)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        //        for index in pairedSensorsList.indices {
        //            guard pairedSensorsList[index].peripheral == peripheral else { return }
        //        }
    }
}

