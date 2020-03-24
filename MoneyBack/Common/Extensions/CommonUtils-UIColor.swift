//
//  CommonUtils-UIColor.swift
//  MoneyBack
//
//  Created by Marcelo Perretta  on 4/6/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func defaultColor() -> UIColor {
        return UIColor(rgb: 0x11a8ab)
    }
    
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
