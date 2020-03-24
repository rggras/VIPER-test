//
//  Expense.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 3/31/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

import ObjectMapper

class Expense: Mappable {
    var ticketNumber: String?
    var date: NSDate?
    var amount: Double?
    var projectName: String?
    var subject: String?
    var coin: String?
    var imageURL: String?
    var imageData: String?
    var expenseId: NSInteger?
    var status: String?
    var type: String?
    
    init() {}
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        ticketNumber <- map["idTicket"]
        date <- (map["date"], DateTransform())
        amount <- map["amount"]
        projectName <- map["project"]
        subject <- map["concept"]
        coin <- map["coin_type"]
        expenseId <- map["id"]
        status <- map["status"]
        type <- map["type"]
    }
    
    func  dataForServer() -> NSDictionary {
        return self.toJSON()
    }
}
