//
//  Simply_WeatherTests.swift
//  Simply WeatherTests
//
//  Created by Gabriel Moreno on 03/11/2019.
//  Copyright © 2019 Gabriel Moreno. All rights reserved.
//

import XCTest
@testable import Simply_Weather

class UtilsTests: XCTestCase {

    override class func tearDown() {
        LocalDataManagerMock.getUserDefaults().removeObject(forKey: "saved_cities")
    }
    
    func testStringExtension() {
        let jsonString = "{\"valid\":false}"
        let validJsonObject = try? jsonString.toJSON()
        XCTAssertNotNil(validJsonObject)
        XCTAssertEqual(validJsonObject!["valid"] as! Bool, false)
        
        let invalidString = "This is not valid"
        let nonValidJsonObject = try? invalidString.toJSON()
        XCTAssertNil(nonValidJsonObject)
        
        let nonValidJsonObject2:String? = nil
        XCTAssertNil(nonValidJsonObject2?.toJSON)
    }

    func testLocalDataManager() {
        let citis = LocalDataManagerMock.getSavedCityList()
        XCTAssertTrue(citis.isEmpty)
        LocalDataManagerMock.saveCity("Barcelona")
        LocalDataManagerMock.saveCity("Helsinki")
        var citiesSaved = LocalDataManagerMock.getSavedCityList()
        XCTAssertEqual(citiesSaved.count, 2)
        LocalDataManagerMock.deleteCity("Barcelona")
        citiesSaved = LocalDataManagerMock.getSavedCityList()
        XCTAssertEqual(citiesSaved.count, 1)
        XCTAssertEqual(citiesSaved.first ?? "", "Helsinki")
    }
    
    let networkManager = NetworkManager(session:URLSessionMock())
    
    func testServer() {
        networkManager.getCurrentWeather(fromCity: "London") { (item, error) in
            XCTAssertNotNil(item)
        }
    }
}
