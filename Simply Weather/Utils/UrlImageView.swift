//
//  UrlImageView.swift
//  Simply Weather
//
//  Created by Gabriel Moreno on 03/11/2019.
//  Copyright © 2019 Gabriel Moreno. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class UrlImageView : UIImageView {
    
    var tmpUrlString:String?
    
    func loadFromUrl(_ urlString:String) {
        self.tmpUrlString = urlString
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            NSLog("Image was already on cache. Download not needed")
            return
        }
        
        URLSession.shared.dataTask(with: URL(string:urlString)!) {
            (data,response,error) in
            if error != nil || data == nil {
                NSLog("There has been some error trying to load the image from url")
                return
            }
            let downloadedImage = UIImage(data: data!)
            //Checking that the downloaded image is the same that was intended to be downloaded
            //This check will avoid issues when using into CollectionViews/TableViews due it's recycling.
            if self.tmpUrlString == urlString {
                DispatchQueue.main.async {
                    self.image = downloadedImage
                }
            }
            imageCache.setObject(downloadedImage!, forKey: urlString as NSString)
        }
    }
}
