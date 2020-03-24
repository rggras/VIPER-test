//
//  MyExpensesPresenter.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 3/31/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit

protocol MyExpensesPresenterInput {
    func presentExpense(response: MyExpensesResponse)
    func presentExpenseSuccess(success: Bool)
}

protocol MyExpensesPresenterOutput: class {
    func displayExpenses(viewModel: MyExpensesViewModel)
    func displaySuccessMessage(message: String)
    func displayErrorMessage(message: String)
}

class MyExpensesPresenter: MyExpensesPresenterInput {
    weak var output: MyExpensesPresenterOutput!
    
    // MARK: Presentation logic

    func presentExpense(response: MyExpensesResponse) {
        var displayedExpenses: [MyExpensesViewModel.DisplayedExpense] = []
        
        for expense in response.expenses {
            
            let ticketNumber = expense.ticketNumber ?? "No Disponible"
            let date = expense.date.flatMap({ dateFormatter.stringFromDate($0) }) ?? "No Disponible"
            let amount = "$ \(expense.amount ?? 0)"

            let displayedExpense = MyExpensesViewModel.DisplayedExpense(ticketNumber: ticketNumber, date: date, status: expense.status, amount: amount, projectName: expense.projectName, subject: expense.subject, coin:expense.coin)
            
            displayedExpenses.append(displayedExpense)
        }
        
        let viewModel = MyExpensesViewModel(displayedExpenses: displayedExpenses)
        output.displayExpenses(viewModel)
    }
    
    func presentExpenseSuccess(success: Bool) {
        if success {
            output.displaySuccessMessage("Tu Gasto fue enviado correctamente")
        } else {
            output.displayErrorMessage("Ocurrió un error al intentar enviar el gasto")
        }
    }

    // MARK: Lazy
    
    lazy var dateFormatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        return dateFormatter
    }()
}
