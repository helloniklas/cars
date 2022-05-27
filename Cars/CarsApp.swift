//
//  CarsApp.swift
//  Cars
//
//  Created by Niklas Alvaeus on 27/05/2022.
//

import SwiftUI
import Combine

@main
struct CarsApp: App {
    
    private let configService = ConfigService(makes: CarsApp.makes)
    private let usedCarsService = UsedCarService(networkAPI: NetworkAPI(), make: CarsApp.makes.first!)
    private var subscriptions = Set<AnyCancellable>()

    init() {
        configService.$selectedMake
            .assign(to: \.make, on: usedCarsService)
            .store(in: &subscriptions)

        configService.$selectedModel
            .assign(to: \.model, on: usedCarsService)
            .store(in: &subscriptions)

        configService.$selectedYear
            .assign(to: \.year, on: usedCarsService)
            .store(in: &subscriptions)

    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(configService)
                .environmentObject(usedCarsService)
        }
    }
    
    static let makes = [
        Car.Make(name: "Mini",
                 models: [Car.Model(name: "Countryman"),
                          Car.Model(name: "Paceman")]),

        Car.Make(name: "BMW", models: [Car.Model(name: "Hatchback"),
                                       Car.Model(name: "Coupe")]),

        Car.Make(name: "Volvo", models: [Car.Model(name: "Saloon")])
    ]
}


