//
//  ViewController.swift
//  Simply Weather
//
//  Created by Gabriel Moreno on 03/11/2019.
//  Copyright © 2019 Gabriel Moreno. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NetworkProvider.shared.getCurrentWeather {
                   (jsonString, error) in
                   if error != nil || jsonString == nil {
                       NSLog("Some error occurred")
                       return
                   }
                   NSLog("\(jsonString!)")
                   
               }
    }


}

