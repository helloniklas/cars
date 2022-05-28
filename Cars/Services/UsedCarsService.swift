//
//  UsedCarsService.swift
//  Cars
//
//  Created by Niklas Alvaeus on 27/05/2022.
//

import SwiftUI
import Combine

class UsedCarService: ObservableObject {
    
    @Published var error: NetworkAPI.Error? {
        didSet {
            if error != nil {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
            }
        }
    }
    @Published var usedCars: [UsedCar] = []

    private let networkAPI: Networkable
    private var subscriptions = Set<AnyCancellable>()

    let generator = UINotificationFeedbackGenerator()

    init(networkAPI: Networkable, make: Car.Make) {
        self.make = make
        self.model = make.models.first!
        self.networkAPI = networkAPI
    }
    
    var make: Car.Make

    var model: Car.Model {
        didSet {
            fetchUsedCars()
        }
    }
    var year: Int = 2022 {
        didSet {
            fetchUsedCars()
        }
    }
    
    func fetchUsedCars() {
        networkAPI
            .fetchUsedCar(make: make.name, model: model.name, year: String(year))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                if case .failure(let error) = completion {
                    print(error.localizedDescription)
                    self.error = error
                }
            }, receiveValue: { [weak self] usedCars in
                guard let self = self else { return }
                self.usedCars = usedCars
                self.error = nil
            }).store(in: &subscriptions)
    }
    
}
