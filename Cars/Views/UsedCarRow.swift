//
//  UsedCarRow.swift
//  Cars
//
//  Created by Niklas Alvaeus on 27/05/2022.
//

import SwiftUI

struct UsedCarRow: View {
    
    var usedCar: UsedCar
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(usedCar.title)
                .font(.title3)
            HStack {
                Text(usedCar.name)
                    .font(.caption)
                Text(usedCar.year)
                    .font(.caption)
                Spacer()
                Text(usedCar.price)
                    .font(.caption)
                    .bold()
                    .foregroundColor(.red)
            }
        }
    }
    
}

struct UsedCarRow_Previews: PreviewProvider {
    static var previews: some View {
        UsedCarRow(usedCar: UsedCar(id: "1", name: "BMW", title: "For sale", make: "Hatchback", model: "New", year: "2022", price: "£40,000"))
    }
}
