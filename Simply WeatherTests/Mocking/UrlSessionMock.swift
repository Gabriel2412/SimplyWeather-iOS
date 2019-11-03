//
//  MockUrlSession.swift
//  Simply WeatherTests
//
//  Created by Gabriel Moreno on 03/11/2019.
//  Copyright © 2019 Gabriel Moreno. All rights reserved.
//

import Foundation
@testable import Simply_Weather

class URLSessionMock: URLSessionProtocol {
    private (set) var lastURL: URL?

    func dataTaskWithURL(url: URL, completionHandler: (Data?, URLResponse?, Error?) -> Void)
-> URLSessionDataTaskProtocol
    {
        lastURL = url
        let jsonData = TestUtilities().getServerMockedJSON()
        let mockedData = (try? JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted))!
        completionHandler(mockedData, nil , nil)
        return MockURLSessionDataTask()
    }
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false

    func resume() {
        resumeWasCalled = true
    }
}
