//
//  ContentView.swift
//  BetterRest
//
//  Created by Dmitry on 31.05.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
   @State private var alertTitle = ""
   @State private var alertMessage = ""
   @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack(alignment: .leading, spacing: 0, content: {
                        Text("When do you want to wake up?")
                            .font(.headline)
                        
                        DatePicker("Please enter a time",
                                   selection: $wakeUp,
                                   displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .datePickerStyle(WheelDatePickerStyle())
                    })
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }.padding()
                }
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Daily coffee intake")
                        .font(.headline)
                    Picker("number of cup", selection: $coffeeAmount) {
                        ForEach(1..<11) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                }
                
                HStack {
                    Text("Your ideal bed time is")
                    Spacer()
                    Text("\(calculateBedTime())")
                }
            }
            .navigationBarTitle("BetterRest")
//            .navigationBarItems(trailing:
//                                    Button(action: calculateBedTime, label: {
//                                        Text("Calculate")
//                                    })
//            )
//            .alert(isPresented: $showingAlert, content: {
//                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
//            })
        }
    }
    private func calculateBedTime() -> String {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            return formatter.string(from: sleepTime)
//            alertTitle = "Your ideal bedtime is..."
            
        } catch {
            // something wrong
            alertTitle = "Error"
            alertMessage = "Sorry, there was a promplem calculating your bedtime"
        }
        
        showingAlert = true
        return ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
