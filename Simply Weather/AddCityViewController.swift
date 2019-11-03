//
//  AddCityViewController.swift
//  Simply Weather
//
//  Created by Gabriel Moreno on 03/11/2019.
//  Copyright © 2019 Gabriel Moreno. All rights reserved.
//

import UIKit
protocol AddCityDelegate {
    func newWeatherItem(_ item: WeatherItem)
}
class AddCityViewController : UIViewController {
    fileprivate let CELL_IDENTIFIER = "SimpleTableViewCell"
    @IBOutlet weak var cityNameTextField: UITextField!
    fileprivate let networkManager = NetworkManager(session: URLSession.shared)
    var delegate:AddCityDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onPressDone(_ sender: Any) {
        if let text = cityNameTextField.text, !text.isEmpty {
            networkManager.getCurrentWeather(fromCity: text) { (item, error) in
                if error == nil && item != nil {
                    self.delegate?.newWeatherItem(item!)
                    self.navigationController?.popViewController(animated: true)
                } else {
                    //City not found error
                    self.showSimpleError("The city you write hasn't been found, make sure is spelled correctly.")
                }
            }
        } else {
            //Text must have valid value
            self.showSimpleError("You must input a city name to search.")
        }
    }
}
