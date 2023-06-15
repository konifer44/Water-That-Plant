//
//  PlantView.swift
//  Water That Plant
//
//  Created by Jan Konieczny on 03.06.23.
//

import SwiftUI

struct PlantView: View {
    @Environment(\.managedObjectContext) var moc
    @FocusState private var focusState: Bool
    
    @StateObject var viewModel: PlantViewModel
    
    var bleManager = BLEManager.shared
    
    @State var isEdited: Bool = false
    @State private var showingSaveErrorAlert = false
    @State private var showingSaveOrCancelAlert = false
    
    init(plant: Plant) {
        _viewModel = StateObject(wrappedValue: PlantViewModel(plant: plant))
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0){
            Image("fikus")
                .resizable()
                .scaledToFill()
                .frame(height: 300)
                .clipped()
        
            Group{
                switch isEdited {
                case true:
                    TextField(viewModel.plant.name ?? "Enter name", text: $viewModel.newName)
                        .modifier(TextFieldClearButton(text: $viewModel.newName))
                        .foregroundColor(.gray)
                        .padding(.bottom, 0.5)
                        .focused($focusState)
                case false:
                    Text(viewModel.plant.name ?? "")
                        .font(.title)
                }
            }
            .frame(height: 35)
            .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 10))
            .font(.title)
            .bold()
            Divider()
            
            List {
                if !isEdited && viewModel.plant.peripheralUUID != nil {
                    PlantCurrentConditionsView(plant: viewModel.plant)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                
                VStack {
                    HStack {
                        Image(systemName: "line.3.horizontal")
                        Text("PLANT DETAILS")
                        Spacer()
                    }
                    .font(.body)
                    .foregroundColor(.gray)
                }
                
                
                HStack{
                    Text("Room Location:")
                    Spacer()
                    switch isEdited {
                    case true:
                        Picker("", selection: $viewModel.plant.selectedRoom) {
                            ForEach(RoomsType.allCases, id: \.self) {
                                Text($0.rawValue).tag($0)
                            }
                        }
                    case false:
                        //Text("\(plant.humidity.range.lowerBound)-\(plant.humidity.range.upperBound)%")
                        Text(viewModel.plant.selectedRoom.rawValue)
                    }
                }
                
                HStack{
                    Text("Recommended Humidity")
                    Spacer()
                    switch isEdited {
                    case true:
                        Picker("", selection: $viewModel.selectedRecommendedHumidity){
                            ForEach(RecommendedHumidityType.allCases, id: \.self){
                                Text("\($0.range.lowerBound)-\($0.range.upperBound)%")
                            }
                        }
                        .labelsHidden()
                    case false:
                        Text("\(viewModel.plant.recommendedHumidity.range.lowerBound)-\(viewModel.plant.recommendedHumidity.range.upperBound)%")
                    }
                }
                
                HStack{
                    Text("Recommended Lighting")
                    Spacer()
                    switch isEdited {
                    case true:
                        Picker("", selection: $viewModel.selectedRecommendedLighting){
                            ForEach(RecommendedLightingType.allCases, id: \.self){
                                Text("\($0.range.lowerBound)-\($0.range.upperBound)%")
                            }
                        }
                        .labelsHidden()                  case false:
                        Text("\(viewModel.plant.recommendedLighting.range.lowerBound)-\(viewModel.plant.recommendedLighting.range.upperBound)%")
                    }
                }
                
                HStack{
                    Text("Recommended Fertilization").lineLimit(1)
                    Spacer()
                    switch isEdited {
                    case true:
                        Spacer()
                        Picker("", selection: $viewModel.selectedRecommendedFertilization){
                            ForEach(RecommendedFertilizationType.allCases, id: \.self){
                                Text($0.rawValue)
                            }
                        }
                        .labelsHidden()
                    case false:
                        Text(viewModel.plant.recommendedFertilization.rawValue)
                    }
                }
                
                HStack{
                    Text("Date of buy")
                    Spacer()
                    switch isEdited {
                    case true:
                        DatePicker("", selection: $viewModel.selectedDate, in: ...Date(), displayedComponents: .date)
                          .labelsHidden()
                        Text("")
                    case false:
                        Text(viewModel.plant.dateOfBuy?.addingTimeInterval(600) ?? Date(), style: .date)
                    }
                }
                
                HStack{
                    Text("Is favourite")
                    Spacer()
                    switch isEdited {
                    case true:
                        Toggle("", isOn: $viewModel.selectedIsFavourite)
                    case false:
                        Text("\(viewModel.plant.isFavourite ? "Yes" : "No")")
                    }
                }
                
                HStack{
                    Text("Have sensor?")
                    Spacer()
                    switch isEdited {
                    case true:
                        NavigationLink(""){
                            SensorsListView(bindedPeripheralIdentifier: $viewModel.selectedPeripheralUUID, alertItemTitle: viewModel.plant.name ?? "plant")
                        }
                        .frame(width: 50)
                    case false:
                        Text("\(viewModel.plant.peripheralUUID == nil  ? "No" : "Yes")")
                    }
                }
            }
            .listStyle(.plain)
            
        }
        
        .simultaneousGesture(DragGesture().onChanged(){_ in
            focusState = false
        })
        
        .alert(isPresented: $showingSaveErrorAlert) {
                    Alert(title: Text("Plant saving error"),
                          message: Text("Your changes won't be saved"),
                          dismissButton: .default(Text("Ok")))
        }
        
        .alert("Do you save changes?", isPresented: $showingSaveOrCancelAlert) {
            Button("Save") {
                viewModel.savePlant { success, message in
                    if success {
                        withAnimation {
                            isEdited = false
                        }
                    } else {
                        showingSaveErrorAlert = true
                        viewModel.cancelChanges()
                    }
                }
            }
            Button("Discard", role: .cancel) {
                viewModel.cancelChanges()
                isEdited = false
            }
        }
        
        
        
        .toolbar{
            Button {
                switch isEdited {
                case true:
                    withAnimation {
                        if viewModel.hasChanges() {
                            showingSaveOrCancelAlert = true
                        } else {
                            isEdited = false
                        }
                       
                    }
    
                case false:
                    withAnimation {
                        isEdited = true
                    }
                }
                
            } label: {
                switch isEdited {
                case true:
                    Text("Done")
                case false:
                    Text("Edit")
                }
            }

        }
        .ignoresSafeArea()
        
    }
}

struct PlantView_Previews: PreviewProvider {
    static let context = PersistenceController.previewPlant.container.viewContext
    
    static var previews: some View {
        NavigationStack {
            PlantView(plant: previewPlant)
                .environment(\.managedObjectContext, context)
        }
    }
}


