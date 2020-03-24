//
//  ExpenseManager.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 4/1/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

private let spendAndInfoEndpoint = "/request"
private let addExpenseEndpoint = "/spend"

extension NetworkManager {
    func getExpenses(success: [Expense] -> Void) {
        
        Alamofire.request(.GET, self.baseUrl + endpoint + spendAndInfoEndpoint).responseArray {
            (response: Response<[Expense], NSError>) in
                success(response.result.value!)
        }
    }
    
    func addExpense(expenseData: Expense, success: Bool -> Void) {
        Alamofire.request(.POST, self.baseUrl + endpoint + spendAndInfoEndpoint + addExpenseEndpoint, parameters: expenseData.dataForServer() as? [String : AnyObject]).responseJSON {
            
            (response) in
            debugPrint(response)
            success(response.result.isSuccess)
        }
    }
}
