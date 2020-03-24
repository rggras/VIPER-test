//
//  NewExpenseInteractor.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 3/31/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit
import ObjectMapper

protocol NewExpenseInteractorInput {
    func formatExpenseDate(date: NSDate)
    func formatAmountNumber(oldRequestValue: String, shouldReplaceInRange range: NSRange, withNewValue newRequestValue: String)
    func addExpense(expenseData: NewExpenseRequest)
    func getCoinTypes()
    func getConceptsTypes()
    func getProjects()
    func validateForm(expenseData: NewExpenseRequest)
    func validateExpndCell(value: String)
}

protocol NewExpenseInteractorOutput {
    func presentExpenseSuccess(success: Bool)
    func presentExpenseDate(date: NSDate)
    func presentCoinTypes(response: [String])
    func presentConceptsTypes(response: [String])
    func presentProjects(response: NewExpenseProjectsResponse)
    func presentFileNumber(value: String)
    func presentAmount(value: NSNumber)
    func enableSendButton(value: Bool)
    func expandSubjectExpenceCell(value: Bool)
}

class NewExpenseInteractor: NewExpenseInteractorInput {
    var output: NewExpenseInteractorOutput!
    var worker: NewExpenseWorker!
    
    // MARK: Business logic
    
    func formatExpenseDate(date: NSDate) {
        output.presentExpenseDate(date)
    }
    
    func formatAmountNumber(oldRequestValue: String, shouldReplaceInRange range: NSRange, withNewValue newRequestValue: String) {
        let oldText = oldRequestValue as NSString
        let newText = oldText.stringByReplacingCharactersInRange(range, withString: newRequestValue) as NSString!
        var newTextString = String(newText)
        
        let digits = NSCharacterSet.decimalDigitCharacterSet()
        var digitText = ""
        for c in newTextString.unicodeScalars {
            if digits.longCharacterIsMember(c.value) {
                digitText.append(c)
            }
        }

        output.presentAmount((NSString(string: digitText).doubleValue)/100)
        
    }
    
    func addExpense(expenseData: NewExpenseRequest) {
        worker = NewExpenseWorker()
        let newExpense = Expense()

        if let stringDate = expenseData.date where !stringDate.isEmpty {
            newExpense.date = stringDate.toDateTime()
        }
        
        newExpense.amount = Double(expenseData.amount!)
        newExpense.projectName = expenseData.projectName
        newExpense.subject = expenseData.subject
        newExpense.coin = expenseData.coin
        
        if expenseData.attachedImage != nil {
            let imageData = UIImagePNGRepresentation(expenseData.attachedImage!)
            newExpense.imageData = String(data: imageData!, encoding: NSUTF8StringEncoding)
        }
            
        worker.addExpense(newExpense) { (success) in
            self.output.presentExpenseSuccess(success)
        }
    }
    
    func getCoinTypes() {
        self.output.presentCoinTypes(Constants.ExpenseConst.allCoins)
    }
    
    func getConceptsTypes() {
        self.output.presentConceptsTypes(Constants.ExpenseConst.allConcepts)
    }
    
    func getProjects() {
        worker = NewExpenseWorker()
        worker.getprojects { (projectsServer: [Project]) in
            let response = NewExpenseProjectsResponse(projects:projectsServer)
            self.output.presentProjects(response)
        }
    }
    
    func getFileNumber() {
        let userDefaultworker = UserDefaultsWorker()
        self.output.presentFileNumber(userDefaultworker.getFileNumber())
    }
    
    func validateForm(expenseData: NewExpenseRequest) {

        self.output.enableSendButton(!((expenseData.projectName?.isEmpty)!) &&
            !((expenseData.date?.isEmpty)!) &&
            !((expenseData.docketNumber?.isEmpty)!) &&
            !((expenseData.subject?.isEmpty)!) &&
            !((expenseData.amount?.isEmpty)!) &&
            !((expenseData.coin?.isEmpty)!) &&
            (expenseData.attachedImage != nil))
    }
    
    func validateExpndCell(value: String) {
        self.output.expandSubjectExpenceCell(value == Constants.ExpenseConst.Others.rawValue)
    }
}
