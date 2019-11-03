//
//  TestUtilities.swift
//  Simply WeatherTests
//
//  Created by Gabriel Moreno on 03/11/2019.
//  Copyright © 2019 Gabriel Moreno. All rights reserved.
//

import Foundation
@testable import Simply_Weather

class TestUtilities  {
    
    func getServerMockedJSON() -> [String:Any]{
        if let filepath = Bundle(for: type(of:self))
            .path(forResource:"ServerMockedResponse",ofType:"json") {
            let contents = try? String(contentsOfFile: filepath)
            return (try? contents?.toJSON()) ?? [:]
        }
        return [:]
    }
    
}
