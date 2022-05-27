//
//  ConfigService.swift
//  Cars
//
//  Created by Niklas Alvaeus on 27/05/2022.
//

import SwiftUI
import Combine

class ConfigService: ObservableObject {

    @Published var selectedMake: Car.Make
    @Published var selectedModel: Car.Model
    @Published var selectedYear = 2022
    
    @Published var makes: [Car.Make]
    @Published var models: [Car.Model]
    
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()

    init(makes: [Car.Make]) {
        self.makes = makes
        self.models = makes.first!.models
        self.selectedMake = makes.first!
        self.selectedModel = makes.first!.models.first!
        
        $selectedMake
            .dropFirst()
            .sink { [weak self] value in
                guard let self = self else { return }
                self.models = value.models
                if let model = value.models.first {
                    self.selectedModel = model
                }
            }
            .store(in: &cancellables)
    }
    
}
