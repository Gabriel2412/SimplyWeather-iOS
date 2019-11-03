//
//  StringExtension.swift
//  Simply Weather
//
//  Created by Gabriel Moreno on 03/11/2019.
//  Copyright © 2019 Gabriel Moreno. All rights reserved.
//

import Foundation

extension String {
    
    /**
    Try to parse this string into a json
    - throws: Will throw exception if the String is not a JSON object.
     */
    func toJSON() throws -> [String:Any] {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            } catch {
                throw ParsingError.invalidJSONString
            }
        }
        throw ParsingError.invalidData
    }
}
