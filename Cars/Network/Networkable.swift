//
//  Networkable.swift
//  BreakingBad
//
//  Created by Niklas Alvaeus on 21/04/2022.
//

import Combine
import SwiftUI

protocol Networkable {
    func fetchUsedCar(make: String, model: String, year: String) -> AnyPublisher<[UsedCar], NetworkAPI.Error>
}
