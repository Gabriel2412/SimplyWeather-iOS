//
//  ViewController.swift
//  Simply Weather
//
//  Created by Gabriel Moreno on 03/11/2019.
//  Copyright © 2019 Gabriel Moreno. All rights reserved.
//

import UIKit

class WeatherListViewController: UITableViewController {
    fileprivate let CELL_IDENTIFIER = "WeatherItemTableViewCell"
    fileprivate var weatherItemList:[WeatherItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: CELL_IDENTIFIER, bundle: nil), forCellReuseIdentifier: CELL_IDENTIFIER)
        NetworkProvider.shared.getCurrentWeather(fromCity: "Helsinki") { (weatherItem, error) in
            if error != nil || weatherItem == nil {
                //TODO : HANDLE ERROR
                return
            }
            self.weatherItemList.append(weatherItem!)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            NSLog("Success!")
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER) as! WeatherItemTableViewCell
        cell.configure(self.weatherItemList[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherItemList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }

}

