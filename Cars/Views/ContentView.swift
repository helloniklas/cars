//
//  ContentView.swift
//  Cars
//
//  Created by Niklas Alvaeus on 27/05/2022.
//

import SwiftUI

struct ContentView: View {

    @State private var date = Date()
    @State private var make: String = ""
    @State private var model: String = ""

    var body: some View {
        
        
        VStack {
            
            VStack(spacing: 0) {
                Text("Cars")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .padding(5)
                
                HStack {

                    Spacer()
                    
                    Picker("Make", selection: $model) {
                        Text("Make")
                        Text("Mini")
                        Text("BMW")
                        Text("Volvo")

                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.horizontal)

                    Picker("Model", selection: $make) {
                        Text("Hatchback")
                        Text("SUV")
                        
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.horizontal)

                    
                    Picker("Year", selection: $date) {
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
            .padding(.horizontal)

            Spacer()
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
