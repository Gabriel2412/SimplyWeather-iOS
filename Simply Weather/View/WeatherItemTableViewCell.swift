//
//  WeatherItemTableViewCell.swift
//  Simply Weather
//
//  Created by Gabriel Moreno on 03/11/2019.
//  Copyright © 2019 Gabriel Moreno. All rights reserved.
//

import UIKit

class WeatherItemTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherImageView:UIImageView!
    @IBOutlet weak var cityNameLabel:UILabel!
    @IBOutlet weak var tempLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ weatherItem:WeatherItem) {
        cityNameLabel.text = weatherItem.cityName
        tempLabel.text = "\(weatherItem.temp)\(weatherItem.tempUnit)"
    }
    
}
