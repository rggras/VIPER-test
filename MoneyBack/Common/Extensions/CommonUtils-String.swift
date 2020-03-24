//
//  CommonUtils-String.swift
//  MoneyBack
//
//  Created by Marcelo Perretta  on 4/29/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

import UIKit

extension String {
    func toDateTime() -> NSDate {
        //Create Date Formatter
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        
        let date = dateFormatter.dateFromString(self)
        
        //Return Parsed Date
        return date!
    }
}
