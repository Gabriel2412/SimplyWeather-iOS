//
//  TableRowsTests.swift
//  Simply WeatherTests
//
//  Created by Gabriel Moreno on 03/11/2019.
//  Copyright © 2019 Gabriel Moreno. All rights reserved.
//

import XCTest
@testable import Simply_Weather

class TableRowsTests: XCTestCase {
    
    fileprivate let mockedSimpleTextLabel:UILabel = UILabel()
    fileprivate let mockedWeatherImageView:UrlImageView = UrlImageViewMock()
    fileprivate let mockedCityNameLabel:UILabel = UILabel()
    fileprivate let mockedTempLabel:UILabel = UILabel()
    
    func testSimpleTableViewCell() {
        let testableText = "Test Text"
        let cell = SimpleTableViewCell()
        cell.rowTextLabel = self.mockedSimpleTextLabel
        cell.setText(testableText)
        XCTAssertEqual(cell.rowTextLabel.text, testableText)
    }
    
    func testWeatherItemTableViewCell() {
        let cell = WeatherItemTableViewCell()
        let jsonDictionary = TestUtilities().getServerMockedJSON()
        let item = WeatherItem.parseJSON(jsonDictionary)
        XCTAssertEqual(item.iconUrl, "https://openweathermap.org/img/wn/04d@2x.png")
        cell.weatherImageView = mockedWeatherImageView
        cell.cityNameLabel = mockedCityNameLabel
        cell.tempLabel = mockedTempLabel
        cell.configure(item)
        XCTAssertEqual(cell.tempLabel.text!, "28.03°C")
        XCTAssertEqual(cell.cityNameLabel.text!, "London")
    
        
    }
    
}

class PataMock : NetworkManager {
    
}
