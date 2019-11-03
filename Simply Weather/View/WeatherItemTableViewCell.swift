//
//  WeatherItemTableViewCell.swift
//  Simply Weather
//
//  Created by Gabriel Moreno on 03/11/2019.
//  Copyright © 2019 Gabriel Moreno. All rights reserved.
//

import UIKit

class WeatherItemTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherImageView:UrlImageView!
    @IBOutlet weak var cityNameLabel:UILabel!
    @IBOutlet weak var tempLabel:UILabel!
    
    func configure(_ weatherItem:WeatherItem) {
        cityNameLabel.text = weatherItem.cityName
        tempLabel.text = "\(weatherItem.temp)\(weatherItem.tempUnit)"
        weatherImageView.loadFromUrl(weatherItem.iconUrl)
    }
    
}
