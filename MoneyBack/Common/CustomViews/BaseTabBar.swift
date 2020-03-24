//
//  BaseTabBar.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 4/25/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

import UIKit

class BaseTabBar: UITabBar {
    
    // MARK: Object lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tintColor = UIColor(red: 214/255, green: 66/255, blue: 32/255, alpha: 1)
    }
}
