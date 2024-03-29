//
//  NetworkParsingError.swift
//  Simply Weather
//
//  Created by Gabriel Moreno on 03/11/2019.
//  Copyright © 2019 Gabriel Moreno. All rights reserved.
//

import Foundation

public enum ParsingError : Error {
    case invalidJSONString
    case invalidData
    case missingLatLng
    case requestFailed
}
