//
//  ContentView.swift
//  Challenge 1
//
//  Created by Dmitry on 30.05.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var whatTemperature = 1
    @State private var currentTemperature = 0
    @State private var temp = ""
    
    let temperature = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var resultTemp: Double {
        convertTemp()
    }
    
    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("Current temperature")) {
                        TextField("Enter temperature", text: $temp)
                            .keyboardType(.decimalPad)
                    
                        Picker("Temperature", selection: $currentTemperature) {
                            ForEach(0..<temperature.count) {
                                Text("\(self.temperature[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("what temperature do you need to convert to?")) {
                    Picker("Temperature", selection: $whatTemperature) {
                        ForEach(0..<temperature.count) {
                            Text("\(self.temperature[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    switch whatTemperature {
                    case 0:
                        Text("\(resultTemp, specifier: "%.1f")C")
                    case 1:
                        Text("\(resultTemp, specifier: "%.1f")F")
                    default:
                        Text("\(resultTemp, specifier: "%.1f")K")
                    }
                }
            }
            .navigationBarTitle("TConverter")
        }
    }
    
    private func convertTemp() -> Double {
        let checkTemp = Double(temp) ?? 0
        
        if currentTemperature == 0, whatTemperature == 1 {
            return checkTemp * 1.8 + 32
        } else if currentTemperature == 0, whatTemperature == 2 {
            return checkTemp + 273.15
        } else if currentTemperature == 1, whatTemperature == 0 {
            return (checkTemp - 32) / 1.8
        } else if currentTemperature == 1, whatTemperature == 2 {
            return (checkTemp + 459.67) / 1.8
        } else if currentTemperature == 2, whatTemperature == 0 {
            return checkTemp - 273.15
        } else if currentTemperature == 2, whatTemperature == 1 {
            return checkTemp * 1.8 - 459.67
        } else {
            return checkTemp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
