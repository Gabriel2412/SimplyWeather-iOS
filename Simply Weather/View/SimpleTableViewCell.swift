//
//  SimpleTableViewCell.swift
//  Simply Weather
//
//  Created by Gabriel Moreno on 03/11/2019.
//  Copyright © 2019 Gabriel Moreno. All rights reserved.
//

import UIKit

class SimpleTableViewCell: UITableViewCell {

    @IBOutlet weak var rowTextLabel: UILabel!

    func setText(_ text:String) {
        self.rowTextLabel.text = text
    }

}
