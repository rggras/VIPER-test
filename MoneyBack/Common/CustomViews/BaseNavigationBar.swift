//
//  BaseNavigationBar.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 4/25/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

import UIKit

class BaseNavigationBar: UINavigationBar {

    // MARK: Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        self.barTintColor = UIColor(red: 214/255, green: 66/255, blue: 32/255, alpha: 1)
        self.tintColor = UIColor.whiteColor()
        self.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
}
