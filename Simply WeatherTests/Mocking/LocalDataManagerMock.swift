//
//  LocalDataManagerMock.swift
//  Simply WeatherTests
//
//  Created by Gabriel Moreno on 03/11/2019.
//  Copyright © 2019 Gabriel Moreno. All rights reserved.
//

import Foundation

@testable import Simply_Weather

class LocalDataManagerMock : LocalDataManager {
    
    private static let userDefs = UserDefaults(suiteName:"UserDefaultsForTesting")!
    
    override class func getUserDefaults() -> UserDefaults {
        return userDefs
    }
}
