//
//  MyExpensesModels.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 3/31/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit

struct MyExpensesRequest {}

struct MyExpensesResponse {
    var expenses: [Expense]
}

struct MyExpensesViewModel {
    struct DisplayedExpense {
        var ticketNumber: String?
        var date: String?
        var status: String?
        var amount: String?
        var projectName: String?
        var subject: String?
        var coin: String?
    }
    
    var displayedExpenses: [DisplayedExpense]
}
