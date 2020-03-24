//
//  MyExpensesInteractor.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 3/31/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit

protocol MyExpensesInteractorInput {
    func getExpenses()
    func addExpense(expenseData: MyExpensesViewModel.DisplayedExpense)
}

protocol MyExpensesInteractorOutput {
    func presentExpense(response: MyExpensesResponse)
    func presentExpenseSuccess(success: Bool)
}

class MyExpensesInteractor: MyExpensesInteractorInput {
    var output: MyExpensesInteractorOutput!
    lazy var repository = ExpenseRepository()
    var worker: MyExpensesWorker!

    // MARK: Business logic

    func getExpenses() {
        repository.getExpenses({ (expenses: [Expense]) in
            let response = MyExpensesResponse(expenses: expenses)
            self.output.presentExpense(response)
        })
    }
    
    func addExpense(expenseData: MyExpensesViewModel.DisplayedExpense) {
        let newExpense = Expense()
        newExpense.ticketNumber = expenseData.ticketNumber
        
        if let stringDate = expenseData.date where !stringDate.isEmpty {
            newExpense.date = stringDate.toDateTime()
        }
        
        newExpense.amount = Double(expenseData.amount!)
        newExpense.projectName = expenseData.projectName
        newExpense.subject = expenseData.subject
        newExpense.coin = expenseData.coin

        //repository.addExpense(expenseData) { (expense) in
        //    self.output.presentExpenseSuccess(true)
        //}
        
        worker = MyExpensesWorker()
        worker.addExpense(newExpense) { (success) in
            self.output.presentExpenseSuccess(success)
        }
    }
}
