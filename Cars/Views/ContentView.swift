//
//  ContentView.swift
//  Cars
//
//  Created by Niklas Alvaeus on 27/05/2022.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var configService: ConfigService
    @EnvironmentObject private var usedCarService: UsedCarService
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            List {
                Section {
                    ForEach(usedCarService.usedCars) { usedCar in
                        UsedCarRow(usedCar: usedCar)
                            .padding()
                    }
                } header: {
                    Spacer()
                        .frame(height: 70)
                }
            }
            
            CarPickerView()
                .padding(.horizontal)
            
            if let error = usedCarService.error {
                VStack {
                    Spacer()
                    Text(error.localizedDescription)
                        .padding()
                    Button(action: { usedCarService.fetchUsedCars() }) {
                        Text("Try again")
                    }
                    Spacer()
                }
            }
            
            Spacer()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
