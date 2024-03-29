//
//  AddNewPlant.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 16.07.23.
//


import SwiftUI
import PhotosUI
import CoreData


struct AddPlantView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: AddPlantViewModel
    
    init(viewModel: AddPlantViewModel){
        self.viewModel = viewModel
    }
    
    var body: some View {
        List {
            Section("Name"){
                TextField(viewModel.name.isEmpty ? "Enter name" : viewModel.name, text: $viewModel.name)
                    .modifier(TextFieldClearButton(text: $viewModel.name))
                    .foregroundColor(.gray)
                    .padding(.bottom, 0.5)
            }
            Section("plant requirements"){
                Picker("Humidity", selection: $viewModel.recommendedHumidity){
                    ForEach(RecommendedHumidityType.allCases, id: \.self){
                        Text("\($0.range.lowerBound)-\($0.range.upperBound)%")
                    }
                }
                
                Picker("Lighting", selection: $viewModel.recommendedLighting){
                    ForEach(RecommendedLightingType.allCases, id: \.self){
                        Text("\($0.range.lowerBound)-\($0.range.upperBound)%")
                    }
                }
                Picker("Fertilization", selection: $viewModel.recommendedFertilization){
                    ForEach(RecommendedFertilizationType.allCases, id: \.self){
                        Text($0.rawValue)
                    }
                }
            }
            Section("Details"){
                Picker("Room", selection: $viewModel.selectedRoom) {
                    ForEach(RoomsType.allCases, id: \.self) {
                        Text($0.rawValue).tag($0)
                    }
                }
                
                DatePicker("Date of buy", selection: $viewModel.dateOfBuy, in: ...Date(), displayedComponents: .date)
                
                Toggle("Is favourite", isOn: $viewModel.isFavourite)
            }
            
            
            Section("Sensor"){
                NavigationLink("Select sensor"){
                    SensorsListView(bindedPeripheralIdentifier: $viewModel.peripheralUUID, alertItemTitle: viewModel.name)
                }
            }
            
            Section{
                PhotosPicker(
                    selection: $viewModel.selectedPhotoItem,
                    matching: .images,
                    photoLibrary: .shared()) {
                        Text(viewModel.selectedPhoto == nil ? "Select photo" : "Change photo")
                    }
            }
        }
        
        .toolbarBackground(.teal)
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel", role: .destructive) {
                    // viewModel.clearView()
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save"){
                    viewModel.savePlant { success, error in
                        viewModel.objectWillChange.send()
                        dismiss()
                    }
                }
            }
        }    
    }
    
    let gradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: .gray, location: 0),
            .init(color: .clear, location: 0.7)
        ]),
        startPoint: .bottom,
        endPoint: .top
    )
}

struct AddPlantView_Previews: PreviewProvider {
    @Binding var isPresented = true
    static var previews: some View {
      
        NavigationStack{
            
         
        }.sheet(isPresented: $isPresented){
            NavigationStack{
                AddPlantView(viewModel: AddPlantViewModel())
                    .navigationTitle("Add plant")
            }
        }
        
    }
}
