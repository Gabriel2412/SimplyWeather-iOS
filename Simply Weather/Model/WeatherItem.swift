//
//  WeatherItem.swift
//  Simply Weather
//
//  Created by Gabriel Moreno on 03/11/2019.
//  Copyright © 2019 Gabriel Moreno. All rights reserved.
//

import Foundation

class WeatherItem {
    private let iconCode:String?
    
    let cityName:String
    let temp:Double
    let tempMax:Double
    let tempMin:Double
    let humidity:Int
    let pressure:Int
    let tempUnit:String
    
    var iconUrl:String {
        if let imageCode = iconCode {
            return "https://openweathermap.org/img/wn/\(imageCode)@2x.png"
        } else {
            return "https://openweathermap.org/img/wn/01d@2x.png"
        }
    }
    
    fileprivate init(_ jsonDictionary:[String:Any]) {
        let mainDictionary = jsonDictionary["main"] as! [String:Any]
        cityName = jsonDictionary["name"] as! String
        temp = mainDictionary["temp"] as! Double
        tempMax = mainDictionary["temp_max"] as! Double
        tempMin = mainDictionary["temp_min"] as! Double
        humidity = mainDictionary["humidity"] as! Int
        pressure = mainDictionary["pressure"] as! Int
        iconCode =  (jsonDictionary["weather"] as? [[String:Any]])?.first?["icon"] as? String
        tempUnit = "°C" //For future version, can support Imperial Temperature units.
    }
    
    class func parseJSON(_ dictionary:[String:Any]) -> WeatherItem {
        return WeatherItem(dictionary)
    }
}
