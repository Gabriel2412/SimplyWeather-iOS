//
//  LocalDataManager.swift
//  Simply Weather
//
//  Created by Gabriel Moreno on 03/11/2019.
//  Copyright © 2019 Gabriel Moreno. All rights reserved.
//

import Foundation

class LocalDataManager {

    class func getUserDefaults() -> UserDefaults {
        return UserDefaults.standard
    }
    /**
    Get the list of cities that the user did add.
    - returns: The list of cities saved in UserDefaults.
    */
    class func getSavedCityList() -> [String] {
        return getUserDefaults().array(forKey: "saved_cities") as? [String] ?? []
    }
    
    /**
    Save the given city to the UserDefaults
    - parameter cityName: The name of the city to save.
     */
    class func saveCity(_ cityName:String) {
        updateCity(cityName: cityName, delete: false)
    }
    
    /**
    Delete (if exists) the given city from the UserDefaults
    - parameter cityName: The name of the city to save.
     */
    class func deleteCity(_ cityName:String) {
        updateCity(cityName: cityName, delete: true)
    }
    
    private class func updateCity(cityName:String, delete:Bool) {
        let defs = getUserDefaults()
        var updatedList:[String] = []
        if let listOfCities = defs.array(forKey: "saved_cities") as? [String], listOfCities.count > 0 {
            updatedList.append(contentsOf: listOfCities)
        }
        if delete {
            updatedList = updatedList.filter {$0 != cityName }
        } else {
            if !updatedList.contains(cityName) {
                updatedList.append(cityName)
            }
        }
        defs.set(updatedList, forKey: "saved_cities")
        defs.synchronize()
    }
}
