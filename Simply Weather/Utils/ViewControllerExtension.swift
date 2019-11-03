//
//  ViewControllerExtension.swift
//  Simply Weather
//
//  Created by Gabriel Moreno on 03/11/2019.
//  Copyright © 2019 Gabriel Moreno. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /**
    Display a basic Alert Controller with a dismiss button.
    - parameter errorMsg: The content of the Alert Controller dialog.
    - parameter dismissHandler: A callback when the dismiss button is pressed.
     */
    func showSimpleError(_ errorMsg:String, dismissHandler:(()->Void)? = nil) {
        let dialog = UIAlertController(title: nil, message: errorMsg, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: {
            (action) in
            dismissHandler?()
        }))
        self.present(dialog,animated: true)
    }
}
