//
//  CarPickerView.swift
//  Cars
//
//  Created by Niklas Alvaeus on 27/05/2022.
//

import SwiftUI


struct CarPickerView: View {
    
    @EnvironmentObject private var configService: ConfigService
    
    var body: some View {
    
    VStack(spacing: 0) {
        Text("Cars")
            .font(.title)
            .bold()
            .foregroundColor(.white)
            .padding(5)
        
        HStack {
            
            Spacer()
            
            Picker("Make", selection: $configService.selectedMake) {
                ForEach(configService.makes, id: \.self) {
                    Text($0.name)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.horizontal)
            
            Picker("Model", selection: $configService.selectedModel) {
                ForEach(configService.models, id: \.self) {
                    Text($0.name)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.horizontal)
            
            
            Picker("Year", selection: $configService.selectedYear) {
                Text("Year")
                ForEach(1970...2022, id: \.self) {
                    Text(String($0))
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.horizontal)
            
            Spacer()
        }
        .padding(.bottom)
    }
    .background(Color.gray.cornerRadius(20))
    }
}

struct CarPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CarPickerView()
            .environmentObject(ConfigService(makes: CarsApp.makes))
    }
}
