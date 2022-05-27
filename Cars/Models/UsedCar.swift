//
//  UsedCar.swift
//  Cars
//
//  Created by Niklas Alvaeus on 27/05/2022.
//

import Foundation

struct UsedCar: Identifiable, Decodable {
    var id: String
    var name: String
    var title: String
    var make: String
    var model: String
    var year: String
    var price: String
}
