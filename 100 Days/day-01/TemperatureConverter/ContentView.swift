//
//  ContentView.swift
//  TemperatureConverter
//
//  Created by Lynjai Jimenez on 3/5/25.
//

import SwiftUI

struct ContentView: View {
    @State private var inputTemperature = ""
    @State private var inputUnit = 0 // 0: Celsius, 1: Fahrenheit
    @State private var outputUnit = 1 // 0: Celsius, 1: Fahrenheit
    @State private var outputTemperature = ""
    @State private var showingAlert = false
    @State private var errorMessage = ""
    
    let temperatureUnits = ["Celsius", "Fahrenheit"]
    let gradient = LinearGradient(
        gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    var body: some View {
        ZStack {
            gradient
                .ignoresSafeArea()
            
            VStack {
                Text("Temperature Converter")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                // Card containing the form
                VStack(spacing: 25) {
                    // Input Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Input Temperature")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        HStack {
                            Image(systemName: "thermometer")
                                .foregroundColor(.blue)
                                .font(.system(size: 22))
                            
                            TextField("Enter temperature", text: $inputTemperature)
                                .keyboardType(.decimalPad)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                        }
                        
                        Picker("Input Unit", selection: $inputUnit) {
                            ForEach(0..<temperatureUnits.count, id: \.self) { index in
                                Text(self.temperatureUnits[index])
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.vertical, 5)
                    }
                    .padding(.horizontal)
                    
                    // Arrow indicator
                    Image(systemName: "arrow.down")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.blue)
                    
                    // Output Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Output Temperature")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        Picker("Output Unit", selection: $outputUnit) {
                            ForEach(0..<temperatureUnits.count, id: \.self) { index in
                                Text(self.temperatureUnits[index])
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.vertical, 5)
                        
                        HStack {
                            Image(systemName: "thermometer.sun.fill")
                                .foregroundColor(.orange)
                                .font(.system(size: 22))
                            
                            Text(outputTemperature.isEmpty ? "Result will appear here" : outputTemperature)
                                .font(.system(size: 18, weight: .medium))
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Convert Button
                    Button(action: {
                        convertTemperature()
                    }) {
                        Text("Convert")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue, Color.purple]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(15)
                            .shadow(radius: 3)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                }
                .padding(.vertical)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                .padding()
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Error"),
                message: Text(errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    func convertTemperature() {
        // Clear the output if input is empty
        guard let inputValue = Double(inputTemperature) else {
            errorMessage = "Please enter a valid number"
            showingAlert = true
            return
        }
        
        var result: Double
        
        // Same unit, no conversion needed
        if inputUnit == outputUnit {
            result = inputValue
        }
        // Celsius to Fahrenheit
        else if inputUnit == 0 && outputUnit == 1 {
            result = (inputValue * 9/5) + 32
        }
        // Fahrenheit to Celsius
        else {
            result = (inputValue - 32) * 5/9
        }
        
        // Format the result to 2 decimal places
        outputTemperature = String(format: "%.2f °\(temperatureUnits[outputUnit])", result)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
