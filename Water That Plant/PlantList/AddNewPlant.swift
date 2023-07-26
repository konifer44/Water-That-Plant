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
    
    @Published var newPlant: Plant = previewPlant
    @Published var selectedPhotoItem: PhotosPickerItem? = nil
    @Published var selectedImageData: Data? = nil
    @Published var selectegPhoto: UIImage? = nil {
        didSet {
            if let selectegPhoto {
                newPlant.image = selectegPhoto
            }
        }
    }
    
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
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
    
    let gradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: .gray, location: 0),
            .init(color: .clear, location: 0.7)
        ]),
        startPoint: .bottom,
        endPoint: .top
    )
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ZStack(alignment: .bottom) {
                    Image(uiImage: viewModel.newPlant.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: 300)
                        .clipped()
    
                    Rectangle()
                        .fill(Color(uiColor: .systemGray6))
                        .mask(gradient)
                    
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading) {
                            Text(viewModel.newPlant.name)
                                .font(.title)
                                .bold()
                                .foregroundColor(.oliveGreen)
                            Text(viewModel.newPlant.selectedRoom.rawValue)
                                .font(.headline)
                                .bold()
                                .foregroundColor(Color(uiColor: .systemGray2))
                        }
                        .padding()
                        Spacer()
                    }
                }
                .frame(height: 300)
                
                List {
                    Section("Name"){
                        TextField(viewModel.newPlant.name.isEmpty ? "Enter name" : viewModel.newPlant.name, text: $viewModel.newPlant.name)
                            .modifier(TextFieldClearButton(text: $viewModel.newPlant.name))
                            .foregroundColor(.gray)
                            .padding(.bottom, 0.5)
                    }
                    
                    Section("Details"){
                        Picker("Room", selection: $viewModel.newPlant.selectedRoom) {
                            ForEach(RoomsType.allCases, id: \.self) {
                                Text($0.rawValue).tag($0)
                            }
                        }
                        
                        Picker("Recommended Humidity", selection: $viewModel.newPlant.recommendedHumidity){
                            ForEach(RecommendedHumidityType.allCases, id: \.self){
                                Text("\($0.range.lowerBound)-\($0.range.upperBound)%")
                            }
                        }
                        
                        Picker("Recommended Lighting", selection: $viewModel.newPlant.recommendedLighting){
                            ForEach(RecommendedLightingType.allCases, id: \.self){
                                Text("\($0.range.lowerBound)-\($0.range.upperBound)%")
                            }
                        }
                        Picker("Recommended Fertilization", selection: $viewModel.newPlant.recommendedFertilization){
                            ForEach(RecommendedFertilizationType.allCases, id: \.self){
                                Text($0.rawValue)
                            }
                        }
                        
                        DatePicker("Date of buy", selection: $viewModel.newPlant.dateOfBuy, in: ...Date(), displayedComponents: .date)
                        
                        Toggle("Is favourite", isOn: $viewModel.newPlant.isFavourite)
                    }
                    
                    
                    Section("Sensor"){
                        NavigationLink("Select sensor"){
                            SensorsListView(bindedPeripheralIdentifier: $viewModel.newPlant.peripheralUUID, alertItemTitle: viewModel.newPlant.name)
                        }
                    }
                    
                    Section{
                        PhotosPicker(
                            selection: $viewModel.selectedPhotoItem,
                            matching: .images,
                            photoLibrary: .shared()) {
                                Text(viewModel.selectegPhoto == nil ? "Select photo" : "Change photo")
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
                                viewModel.selectegPhoto = image
                            }
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

struct AddPlantView_Previews: PreviewProvider {
    static let context = PersistenceController.previewList.container.viewContext
    static var previews: some View {
        AddPlantView(viewModel: AddPlantViewModel(moc: context))
    }
}
