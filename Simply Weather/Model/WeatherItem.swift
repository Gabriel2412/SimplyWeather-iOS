//
//  WeatherItem.swift
//  Simply Weather
//
//  Created by Gabriel Moreno on 03/11/2019.
//  Copyright © 2019 Gabriel Moreno. All rights reserved.
//

import Foundation

class WeatherItem {
    //JSON Data Sources
    private let jsonDictionary:[String:Any]
    private var mainDictionary:[String:Any] {
        return self.jsonDictionary["main"] as! [String:Any]
    }
    
    //Class Fields
    var icon:String!
    
    var cityName:String {
        return jsonDictionary["name"] as! String
    }
    
    var temp:Double {
        return mainDictionary["temp"] as! Double
    }
    
    var tempMax:Double {
        return mainDictionary["temp_max"] as! Double
    }
    
    var tempMin:Double {
        return mainDictionary["temp_min"] as! Double
    }
    
    var humidity:Int {
        return mainDictionary["humidity"] as! Int
    }
    
    var pressure:Int {
        return mainDictionary["pressure"] as! Int
    }
    
    var tempUnit:String {
        return "°C"
    }
    
    private init(_ dictionary:[String:Any]) {
        self.jsonDictionary = dictionary
    }
    
    class func parseJSON(_ jsonString:String) throws -> WeatherItem {
        if let data = jsonString.data(using: .utf8) {
            do {
                let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                return WeatherItem(jsonDictionary)
            } catch {
                throw WeatherItemParsingError.invalidJSONString
            }
        }
        throw WeatherItemParsingError.invalidData
    }
}
