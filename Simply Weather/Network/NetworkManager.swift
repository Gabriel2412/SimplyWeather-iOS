//
//  NetworkProvider.swift
//  Simply Weather
//
//  Created by Gabriel Moreno on 03/11/2019.
//  Copyright © 2019 Gabriel Moreno. All rights reserved.
//

import Foundation

class NetworkManager {
    
    let session:URLSessionProtocol
        
    init(session:URLSessionProtocol) {
        self.session = session
    }

    private var urlString:String {
        return Bundle.main.infoDictionary?["NetworkApiUrl"] as! String
    }
    
    private var apiKey:String {
        return Bundle.main.infoDictionary?["NetworkApiKey"] as! String
    }
    
    private var unitType:String {
        return "metric" //Future version can have imperial unit type (Farenheit)
    }
    /**
     Get the current weather of the chosen city
     - parameter fromCity: The city to load the weather from.
     - parameter completion: An async callback with the requested data (Or an error if city was not valid or other errors)
     */
    func getCurrentWeather(fromCity cityName:String, completion: @escaping (WeatherItem?,Error?)->Void) {
        var urlComps = URLComponents(string: self.urlString)
        urlComps?.queryItems = [
            URLQueryItem(name: "q", value: cityName),
            URLQueryItem(name: "APPID", value: self.apiKey),
            URLQueryItem(name: "units", value: self.unitType)
        ]
        var request = URLRequest(url: urlComps!.url!,
                                        cachePolicy: .useProtocolCachePolicy,
                                        timeoutInterval: 10.0)
        request.httpMethod = "GET"
        let dataTask = session.dataTaskWithURL(url: request.url!, completionHandler: {
            (data, response, error) -> Void in
            var reportingError:Error? = error
            var item:WeatherItem?
            if error == nil, let data = data {
                do {
                    if let jsonDictionary = try String(data: data, encoding: .utf8)?.toJSON() {
                        if  jsonDictionary["cod"] as? Int == 200  {
                            item = WeatherItem.parseJSON( jsonDictionary)
                        } else {
                            NSLog("Request did fail. City name could be wrong?")
                            reportingError = ParsingError.requestFailed
                        }
                    } else {
                        NSLog("The data failed to be converted")
                        reportingError = ParsingError.invalidData                    }
                } catch let jsonError {
                    reportingError = jsonError
                }
            }
            //Notifying Main Thread to easier usage.
            DispatchQueue.main.async {
                completion(item,reportingError)
            }
        })
        dataTask.resume()
    }
}
