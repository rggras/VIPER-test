//
//  MyExpensesRouter.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 3/31/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit
import Common

protocol MyExpensesRouterInput: BaseRouter {}

class MyExpensesRouter: BaseRouter, MyExpensesRouterInput {
    weak var viewController: MyExpensesViewController!
    weak var newExpense: NewExpenseViewController!
    
    func editExpense(expense: MyExpensesViewModel.DisplayedExpense) {
        
        let expenseEditable: NewExpenseRequest = NewExpenseRequest(projectName: expense.projectName, date: expense.date, docketNumber: nil, subject: expense.subject, ticketNumber: expense.ticketNumber, amount: expense.amount, coin: expense.coin, attachedImage: nil, status: expense.status)
        
        let storyboard = UIStoryboard(name: "NewExpenseViewController", bundle: NSBundle.mainBundle())
        newExpense = storyboard.instantiateInitialViewController()! as? NewExpenseViewController
        newExpense.expenseToEdit = expenseEditable
        viewController.navigationController?.pushViewController(newExpense, animated: true)
    }
}
