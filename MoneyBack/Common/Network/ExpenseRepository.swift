//
//  ExpenseRepository.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 5/11/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

import Foundation
import Alamofire

class ExpenseRepository {
    // ExpenseRepository needs to manage the loaded expenses
    // For now we are using a local array as a basic cache
    // TODO: check if CoreData or REALM could make it better
    var expenses: [Expense] = [] {
        // TODO: do something here to let the UI know that the expense list 
        //has changed, until we have swiftRx or REALM working
        didSet {
            print("did set Expense")
        }
    }

    func addExpense(expense: Expense, success: Expense -> Void) {
        Alamofire.request(APIRouterExpense.CreateExpense(expense.toJSON())).responseObject {
            (response: Response<Expense, NSError>) in
            
            if response.result.isSuccess {
                success(response.result.value!)
            }
        }
    }
    
    func getExpenses(success: [Expense] -> Void) {
        Alamofire.request(APIRouterExpense.ReadExpenses()).responseArray {
            (response: Response<[Expense], NSError>) in
            
            if response.result.isSuccess {
                self.expenses = response.result.value!
                success(self.expenses)
            }
        }
    }
    
    func updateExpense(expense: Expense, success: Expense -> Void) {
        Alamofire.request(APIRouterExpense.UpdateExpense(expense.toJSON())).responseObject {
            (response: Response<Expense, NSError>) in
            
            if response.result.isSuccess {
                success(response.result.value!)
            }
        }
    }
    
    // TODO: not ready on the API. Please check if is working properly
    // once the endpoint is in place
    func deleteExpense(expenseId: NSInteger, success: Expense -> Void) {
        Alamofire.request(APIRouterExpense.DeleteExpense(expenseId)).responseObject {
            (response: Response<Expense, NSError>) in
            
            if response.result.isSuccess {
                success(response.result.value!)
            }
        }
    }
    
    func getExpenseDetails(expenseId: NSInteger, success: Expense -> Void) {
        // We are saving the expenses locally, so we don't need to call the API
        if let index = expenses.indexOf({$0.expenseId == expenseId}) {
            success(expenses[index])
        }
    }
}
