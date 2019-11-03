//
//  WeatherListViewController.swift
//  Simply Weather
//
//  Created by Gabriel Moreno on 03/11/2019.
//  Copyright © 2019 Gabriel Moreno. All rights reserved.
//

import UIKit

class WeatherListViewController: UITableViewController, AddCityDelegate {
   
    fileprivate let CELL_IDENTIFIER = "WeatherItemTableViewCell"
    fileprivate var weatherItemList:[WeatherItem] = []
    fileprivate var  placeholder:UILabel!
    fileprivate let networkManager = NetworkManager(session: URLSession.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.placeholder = UILabel()
        self.placeholder.text = "Press + to add a city."
        self.placeholder.isHidden = true
        self.placeholder.textAlignment = .center
        self.placeholder.font = self.placeholder.font.withSize(22)
        self.placeholder.backgroundColor = .systemGroupedBackground
        self.tableView.addSubview(placeholder)
        self.tableView.tableFooterView = UIView(frame: .zero)
        
        tableView.register(UINib(nibName: CELL_IDENTIFIER, bundle: nil), forCellReuseIdentifier: CELL_IDENTIFIER)
        
        let cities:[String] =  LocalDataManager.getSavedCityList()
        for city in cities {
            self.loadCity(city)
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.placeholder.frame = self.tableView.bounds;
    }
    
    func loadCity(_ city:String) {
        networkManager.getCurrentWeather(fromCity: city) { (weatherItem, error) in
            if error != nil || weatherItem == nil {
                return
            }
            self.weatherItemList.append(weatherItem!)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func newWeatherItem(_ item: WeatherItem) {
        self.weatherItemList.append(item)
        LocalDataManager.saveCity(item.cityName)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER) as! WeatherItemTableViewCell
        cell.configure(self.weatherItemList[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.placeholder.isHidden = weatherItemList.count > 0
        return weatherItemList.count
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

      let action = UIContextualAction(style: .normal, title: "Delete", handler: {
        (action, view, completionHandler) in
            // Delete the item from the array and the Local Data storage.
            let item = self.weatherItemList.remove(at: indexPath.row)
            LocalDataManager.deleteCity(item.cityName)
            self.tableView.reloadData()
            completionHandler(true)
      })
        
      action.backgroundColor = .red
      let configuration = UISwipeActionsConfiguration(actions: [action])
      return configuration
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "to_new_city" {
            let vc = segue.destination as! AddCityViewController
            vc.delegate = self
        }
    }
}

