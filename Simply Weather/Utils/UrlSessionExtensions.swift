//
//  UrlSessionExtensions.swift
//  Simply Weather
//
//  Created by Gabriel Moreno on 03/11/2019.
//  Copyright © 2019 Gabriel Moreno. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    func dataTaskWithURL(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}


extension URLSession: URLSessionProtocol {
    
    func dataTaskWithURL(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return dataTask(with: url, completionHandler: completionHandler)
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }
