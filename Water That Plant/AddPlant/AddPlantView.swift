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
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.oliveGreen]
        
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    ZStack(alignment: .bottom) {
                        Image(uiImage: viewModel.plant.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: 300)
                            .clipped()
                        
                        Rectangle()
                            .fill(Color(uiColor: .systemGray6))
                            .mask(gradient)
                        
                        HStack(alignment: .bottom) {
                            VStack(alignment: .leading) {
                                Text(viewModel.plant.name)
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(.oliveGreen)
                                Text(viewModel.plant.selectedRoom.rawValue)
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
                        
                        
                        Section("Sensor"){
                            NavigationLink("Select sensor"){
                                SensorsListView(bindedPeripheralIdentifier: $viewModel.plant.peripheralUUID, alertItemTitle: viewModel.plant.name)
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
                    
                    .navigationTitle("Add new")
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
                                    dismiss()
                                }
                            }
                            
                            .foregroundColor(.green)
                        }
                    }
                }
                .edgesIgnoringSafeArea(.top)
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
    static var previews: some View {
        AddPlantView(viewModel: AddPlantViewModel())
    }
}
