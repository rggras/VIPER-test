//
//  MyExpensesWorker.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 3/31/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit

class MyExpensesWorker {
    lazy var expenseManager = NetworkManager()
    
    // MARK: Business Logic    
    func getExpenses(success: [Expense] -> Void) {
        self.expenseManager.getExpenses(success)
    }
    
    func addExpense(expenseData: Expense, success: Bool -> Void) {
        let expenseManager = NetworkManager()
        expenseManager.addExpense(expenseData, success: success)
    }

}
