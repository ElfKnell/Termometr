//
//  ContentView.swift
//  Termometr
//
//  Created by Andrii Kyrychenko on 12/07/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var valueTemp = 0.0
    @State private var startGr = "C"
    @State private var resultGr = "C"
    @FocusState private var amountIsFocused: Bool
    
    var result: Decimal {
        var startValue: Decimal
        switch startGr {
        case "K":
            startValue = kelToCel(tem: Decimal(valueTemp))
        case "F":
            startValue = farToCel(tem: Decimal(valueTemp))
        default:
            startValue = Decimal(valueTemp)
        }
        
        switch resultGr {
            case "K":
            return celToKel(tem: startValue)
        case "F":
            return celToFar(tem: startValue)
        default:
            return startValue
        }
    }
    
    let nameTemp = ["C", "K", "F"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Value", value: $valueTemp, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                } header: {
                    Text("Temperature value")
                }
                
                Section {
                    Picker("Start tempetature", selection: $startGr) {
                        ForEach(nameTemp, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Initial temperature")
                }
                
                Section {
                    Picker("Result temperature", selection: $resultGr) {
                        ForEach(nameTemp, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert temperature")
                }
                
                
                Section {
                    Text(result, format: .number)
                } header: {
                    Text("Temperature result")
                }
            }
        }
        .navigationTitle("Ceange name temperature")
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                Button("Done") {
                    amountIsFocused = false
                }
            }
        }
    }
    
    func celToKel(tem: Decimal) -> Decimal {
        tem + 273.15
    }
    
    func celToFar(tem: Decimal) -> Decimal {
        tem * 1.8 + 32.0
    }
    
    func kelToCel(tem: Decimal) -> Decimal {
        tem - 273.15
    }
    
    func farToCel(tem: Decimal) -> Decimal {
        (tem - 32) * 5 / 9
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
