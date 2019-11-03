//
//  NetworkProvider.swift
//  Simply Weather
//
//  Created by Gabriel Moreno on 03/11/2019.
//  Copyright © 2019 Gabriel Moreno. All rights reserved.
//

import Foundation

class NetworkProvider {
    
    static let shared:NetworkProvider = NetworkProvider()
    
    var urlString:String {
        return Bundle.main.infoDictionary?["NetworkApiUrl"] as! String
    }
    
    var apiKey:String {
        return Bundle.main.infoDictionary?["NetworkApiKey"] as! String
    }
    
    func getCurrentWeather(_ completion: @escaping (_ jsonString:String?,Error?)->Void) {
        var urlComps = URLComponents(string: self.urlString)
        urlComps?.queryItems = [
            URLQueryItem(name: "q", value: "Helsinki"),
            URLQueryItem(name: "APPID", value: self.apiKey)
        ]
        var request = URLRequest(url: urlComps!.url!,
                                        cachePolicy: .useProtocolCachePolicy,
                                        timeoutInterval: 10.0)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            var jsonString:String?
            if error == nil, let data = data {
                jsonString = String(data: data, encoding: .utf8)
            }
            completion(jsonString,error)
        })

        dataTask.resume()
    }
    
}
