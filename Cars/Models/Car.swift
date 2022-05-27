//
//  Car.swift
//  Cars
//
//  Created by Niklas Alvaeus on 27/05/2022.
//

import Foundation

struct Car {
    
    struct Make: Hashable {
        var name: String
        var models: [Model]
    }

    struct Model: Hashable {
        var name: String
    }

}
