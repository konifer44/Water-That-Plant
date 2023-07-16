//
////  SwiftUIView.swift
////  WaterThatPlant
////
////  Created by Jan Konieczny on 28.07.22.
////
//
//import SwiftUI
//import Charts
//
//struct PlantStatiscic: View {
//    @State private var selectedStatistics = 0
//
//    var body: some View {
//        VStack {
//            HStack{
//                HStack{
//                    Image(systemName: "chart.bar.xaxis")
//                        .foregroundColor(.oliveGreen)
//                        .font(.title2)
//                    Text("Plant stats")
//                        .font(.title3)
//                    Spacer()
//                }
//                .padding()
//                Spacer()
//                Picker("What is your favorite color?", selection: $selectedStatistics) {
//                    Text("Hydration").tag(0)
//                    Text("Fertilizer").tag(1)
//                }
//                .pickerStyle(.segmented)
//
//            }
//            switch selectedStatistics {
//            case 0:
//                HydrationChart();
//            case 1:
//                FertilizerChart();
//            default:
//                EmptyView();
//            }
//        }
//    }
//}
//
//struct PlantStatiscic_Previews: PreviewProvider {
//    static var previews: some View {
//        PlantStatiscic()
//    }
//}
//
//struct FertilizerChart: View {
//    var body: some View {
//        Chart {
//            BarMark(
//                x: .value("Mount", "Mon"),
//                y: .value("Value", 2)
//            )
//            BarMark(
//                x: .value("Mount", "Tue"),
//                y: .value("Value", 2.5)
//            )
//            BarMark(
//                x: .value("Mount", "Wen"),
//                y: .value("Value", 1)
//            )
//            BarMark(
//                x: .value("Mount", "Thr"),
//                y: .value("Value", 1.2)
//            )
//            BarMark(
//                x: .value("Mount", "Fri"),
//                y: .value("Value", 0)
//            )
//            BarMark(
//                x: .value("Mount", "Sat"),
//                y: .value("Value", 2)
//            )
//            BarMark(
//                x: .value("Mount", "Sun"),
//                y: .value("Value", 0.1)
//            )
//        }
//
//        .foregroundStyle(Color.brown.gradient)
//    }
//}
//
//struct HydrationChart: View {
//    var body: some View {
//        Chart {
//            BarMark(
//                x: .value("Mount", "Mon"),
//                y: .value("Value", 1)
//            )
//            BarMark(
//                x: .value("Mount", "Tue"),
//                y: .value("Value", 1.5)
//            )
//            BarMark(
//                x: .value("Mount", "Wen"),
//                y: .value("Value", 2)
//            )
//            BarMark(
//                x: .value("Mount", "Thr"),
//                y: .value("Value", 2.2)
//            )
//            BarMark(
//                x: .value("Mount", "Fri"),
//                y: .value("Value", 3)
//            )
//            BarMark(
//                x: .value("Mount", "Sat"),
//                y: .value("Value", 0)
//            )
//            BarMark(
//                x: .value("Mount", "Sun"),
//                y: .value("Value", 0.1)
//            )
//        }
//
//        .foregroundStyle(Color.blue.gradient)
//    }
//}
