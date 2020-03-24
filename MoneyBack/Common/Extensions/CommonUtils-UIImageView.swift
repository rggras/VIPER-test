//
//  CommonUtils-UIImageView.swift
//  MoneyBack
//
//  Created by Marcelo Perretta  on 4/6/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage


extension UIImageView {
    
    /// Helper for download and display an image from some url
    /// - parameter link:        link String value
    /// - parameter placeholder: placeholder UIImage
    public func imageFromUrl(link link: String, placeholderImage placeholder: UIImage? = nil) {
        guard let url = NSURL(string: link) else {return}
        self.af_setImageWithURL(url, placeholderImage: placeholder)        
    }
    
    /// Helper for make an image circular
    public func circularImage() {
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
}
