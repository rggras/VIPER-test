//
//  NewExpenseWorker.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 3/31/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit

class NewExpenseWorker {
    
    // MARK: Business Logic
    func addExpense(expenseData: Expense, success: Bool -> Void) {
        let expenseManager = NetworkManager()
        expenseManager.addExpense(expenseData, success: success)
    }
    
    func getprojects(success: [Project] -> Void) {
        let expenseManager: NetworkManager! = NetworkManager()
        expenseManager.getProjects(success)
    }
}
