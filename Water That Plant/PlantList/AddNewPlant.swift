//
//  AddNewPlant.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 16.07.23.
//


import SwiftUI
import PhotosUI
import CoreData

class AddPlantViewModel: ObservableObject {
    let moc: NSManagedObjectContext
    
    @Published var plant: Plant = previewPlant
    
    @Published var selectedPhotoItem: PhotosPickerItem? = nil
    @Published var selectedImageData: Data? = nil
    @Published var selectegPhoto: Image? = nil
    
    
    init(moc: NSManagedObjectContext, plant: Plant) {
        self.moc = moc
        self.plant = plant
    }
    
    
     func removePhoto(){
        selectedPhotoItem = nil
        selectedImageData = nil
        selectegPhoto = nil
    }
    
    func saveNewPlant(){
     
    }
    
    
    
}


struct AddPlantView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: AddPlantViewModel
    
    init(viewModel: AddPlantViewModel){
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List {
                Section("Name"){
                    TextField(viewModel.plant.name.isEmpty ? "Enter name" : viewModel.plant.name, text: $viewModel.plant.name)
                        .modifier(TextFieldClearButton(text: $viewModel.plant.name))
                        .foregroundColor(.gray)
                        .padding(.bottom, 0.5)
                }
                
                Section("Details"){
                    Picker("Room", selection: $viewModel.plant.selectedRoom) {
                        ForEach(RoomsType.allCases, id: \.self) {
                            Text($0.rawValue).tag($0)
                        }
                    }
               
                    Picker("Recommended Humidity", selection: $viewModel.plant.recommendedHumidity){
                        ForEach(RecommendedHumidityType.allCases, id: \.self){
                            Text("\($0.range.lowerBound)-\($0.range.upperBound)%")
                        }
                    }
                    
                    Picker("Recommended Lighting", selection: $viewModel.plant.recommendedLighting){
                        ForEach(RecommendedLightingType.allCases, id: \.self){
                            Text("\($0.range.lowerBound)-\($0.range.upperBound)%")
                        }
                    }
                    Picker("Recommended Fertilization", selection: $viewModel.plant.recommendedFertilization){
                        ForEach(RecommendedFertilizationType.allCases, id: \.self){
                            Text($0.rawValue)
                        }
                    }
                    
                    DatePicker("Date of buy", selection: $viewModel.plant.dateOfBuy, in: ...Date(), displayedComponents: .date)
                    
                    Toggle("Is favourite", isOn: $viewModel.plant.isFavourite)
                }
                
                Section{
                    NavigationLink("Sensor"){
                        SensorsListView(bindedPeripheralIdentifier: $viewModel.plant.peripheralUUID, alertItemTitle: viewModel.plant.name)
                    }
                }
            }
            .navigationTitle("Add new plant")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .destructive) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save"){
                        viewModel.saveNewPlant()
                        dismiss()
                    }
                
                    .foregroundColor(.green)
                }
                
                
                
                
                
                
                
            }
            .onChange(of: viewModel.selectedPhotoItem) { newPhotoItem in
                Task {
                    if let data = try? await newPhotoItem?.loadTransferable(type: Data.self) {
                        viewModel.selectedImageData = data
                        if let image = UIImage(data: data) {
                            viewModel.selectegPhoto = Image(uiImage: image)
                        }
                    }
                }
            }
        }
    }
    
    
}

struct AddPlantView_Previews: PreviewProvider {
    static let context = PersistenceController.previewList.container.viewContext
    static var previews: some View {
        AddPlantView(viewModel: AddPlantViewModel(moc: context, plant: previewPlant))
    }
}
