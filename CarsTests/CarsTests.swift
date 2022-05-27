//
//  CarsTests.swift
//  CarsTests
//
//  Created by Niklas Alvaeus on 27/05/2022.
//

import XCTest
import Combine
@testable import Cars

class CarsTests: XCTestCase {

    static let makes = [
        Car.Make(name: "Mini",
                 models: [Car.Model(name: "Countryman"),
                          Car.Model(name: "Paceman")]),

        Car.Make(name: "BMW", models: [Car.Model(name: "Hatchback"),
                                       Car.Model(name: "Coupe")]),

        Car.Make(name: "Volvo", models: [Car.Model(name: "Saloon")])
    ]
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchUsedCarsSuccess() {
        // If
        let make = CarsTests.makes.first!
        let usedCarService = UsedCarService(networkAPI: MockNetworkAPI(), make: make)
        
        // When
        usedCarService.model = make.models.first!
        
        // Then
        let expectation = expectation(description: "Test after 0.1 seconds")
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.1)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(usedCarService.usedCars.first?.price == "£4000")
        }
        else {
            XCTFail("Delay interrupted")
        }
    }
    
    func testFetchUsedCarsFail() {
        // If
        let make = CarsTests.makes.first!
        let usedCarService = UsedCarService(networkAPI: MockNetworkAPI(), make: make)
        
        // When
        usedCarService.model = make.models.first!
        
        // Then
        let expectation = expectation(description: "Test after 0.1 seconds")
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.1)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertFalse(usedCarService.usedCars.first?.price == "£6000")
        }
        else {
            XCTFail("Delay interrupted")
        }
    }
    
    func testConfigServiceSuccess() {
        // If
        let configService = ConfigService(makes: CarsTests.makes)

        // When
        configService.selectedMake = CarsTests.makes[2]
        
        // Then
        XCTAssertTrue(configService.models.first?.name == "Saloon")
    }

    func testConfigServiceFail() {
        // If
        let configService = ConfigService(makes: CarsTests.makes)

        // When
        configService.selectedMake = CarsTests.makes[1]
        
        // Then
        XCTAssertFalse(configService.models.first?.name == "Saloon")
    }

}

class MockNetworkAPI: Networkable {
    func fetchUsedCar(make: String, model: String, year: String) -> AnyPublisher<[UsedCar], NetworkAPI.Error> {
        print("in mock")
        let response = [UsedCar(id: "1", name: "BMW", title: "For sale", make: "Hatchback", model: "BMW", year: "2022", price: "£4000"),
                        UsedCar(id: "2", name: "BMW", title: "For sale", make: "Hatchback", model: "BMW", year: "2003", price: "£1000")]
        return CurrentValueSubject(response).eraseToAnyPublisher()
    }
    


}
