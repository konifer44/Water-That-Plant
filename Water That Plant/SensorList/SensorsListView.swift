//
//  SensorsListView.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 16.04.23.
//

import SwiftUI

struct SensorsListView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = SensorsListViewModel()
    @Binding var bindedPeripheralIdentifier: UUID?
    @State var isConnectedToBindedPeripheral: Bool = false
    
    @State var alertItemTitle: String
    @State var selectedPeripheralIdentifier: UUID?
    @State private var showingPairSensorAlert: Bool = false
    @State private var showingUnpairSensorAlert: Bool = false
    
    var body: some View {
        List {
            Section("Sensor paired to this plant") {
                if let bindedPeripheralIdentifier {
                    HStack{
                        Text(bindedPeripheralIdentifier.uuidString)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        Image(systemName: "dot.radiowaves.up.forward")
                            .foregroundColor(isConnectedToBindedPeripheral ? .green : .gray)
                    }
                    .onTapGesture {
                        selectedPeripheralIdentifier = bindedPeripheralIdentifier
                        showingUnpairSensorAlert = true
                    }
                } else {
                    Text("No sensor paired to this plant")
                }
            }
            
            if viewModel.bleManager.peripheralList.isEmpty {
                Section("Available sensors") {
                    Text("No available sensors")
                }
            } else {
                Section("Available sensors"){
                    if viewModel.bleManager.peripheralList.filter({ $0.identifier != bindedPeripheralIdentifier }).isEmpty {
                        Text("No available sensors")
                    } else {
                        ForEach(viewModel.bleManager.peripheralList.filter{ $0.identifier != bindedPeripheralIdentifier }, id: \.self){ peripheral in
                            Text(peripheral.identifier.uuidString)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                                .onTapGesture {
                                    selectedPeripheralIdentifier = peripheral.identifier
                                    showingPairSensorAlert = true
                                }
                            
                        }
                    }
                }
            }
        }
        .navigationTitle("Sensors List")
        .onAppear(){
            viewModel.startScanningForPeripherals()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if let bindedPeripheralIdentifier {
                    viewModel.connectToPeripheral(with: bindedPeripheralIdentifier)
                    isConnectedToBindedPeripheral =  viewModel.bleManager.isConnected(uuid: bindedPeripheralIdentifier)
                }
            }
        }
        .onDisappear(){
            viewModel.stopScanningForPeripherals()
        }
    
        .alert("Do you want pair this sensor with \(alertItemTitle)?", isPresented: $showingPairSensorAlert, presenting: selectedPeripheralIdentifier) { selectedPeripheralIdentifier in
            Button("Pair") {
                self.bindedPeripheralIdentifier = selectedPeripheralIdentifier
                // dismiss()
                
            }
            Button("Cancel", role: .cancel) {
            }
        }
    
        .alert("Do you want unpair this sensor?", isPresented: $showingUnpairSensorAlert, presenting: selectedPeripheralIdentifier) { selectedPeripheralIdentifier in
            Button("Unpair") {
                let availablePeripherals = viewModel.bleManager.peripheralList
                bindedPeripheralIdentifier = nil
            }
            Button("Cancel", role: .cancel) {
                
            }
        }
}
}

struct SensorsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SensorsListView(bindedPeripheralIdentifier: .constant(UUID()), alertItemTitle: "Kaktus")
        }
    }
}



