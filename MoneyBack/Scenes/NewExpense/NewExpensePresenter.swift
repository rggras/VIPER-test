//
//  NewExpensePresenter.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 3/31/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit

protocol NewExpensePresenterInput {
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

protocol NewExpensePresenterOutput: class {
    func displaySuccessMessage(message: String)
    func displayErrorMessage(message: String)
    func displayExpenseDate(date: String)
    func displayCoinsType(coinsType: [String])
    func displayConceptsType(conceptsType: [String])
    func displayProjectsType(projectsType: [String])
    func displayFileNumber(value: String)
    func displayAmountNumberFormatted(value: String)
    func displayEnableButton(value: Bool)
    func displayExpandedSubjectCell(value: Bool)
    
}

class NewExpensePresenter: NewExpensePresenterInput {
    weak var output: NewExpensePresenterOutput!

    // MARK: Presentation logic

    func presentExpenseSuccess(success: Bool) {
        var message = "Your expense fails"
        if success {
            message = "Your expense was added correctly"
            output.displaySuccessMessage(message)
        } else {
            output.displayErrorMessage(message)
        }
    }

    func presentExpenseDate(date: NSDate) {
        let formatedDate = dateFormatter.stringFromDate(date)
        output.displayExpenseDate(formatedDate)
    }
    
    func presentCoinTypes(response: [String]) {
        return output.displayCoinsType(response)
    }
    
    func presentConceptsTypes(response: [String]) {
        return output.displayCoinsType(response)
    }
    
    func presentProjects(response: NewExpenseProjectsResponse) {
        let projectsData = response.projects
        
        var projectTypes: [String] = []
        
        if !projectsData.isEmpty {
            for project: Project in projectsData {
                projectTypes.append(project.name!)
            }
        }
        
        return output.displayProjectsType(projectTypes)
    }
    
    func presentFileNumber(value: String) {
        if value.isEmpty {
            return output.displayFileNumber("No value")
        }
        return output.displayFileNumber(value)
    }
    
    func presentAmount(value: NSNumber) {
        let formatedAmount = numberFormatter.stringFromNumber(value)
        output.displayAmountNumberFormatted(formatedAmount!)
    }
    
    func enableSendButton(value: Bool) {
        output.displayEnableButton(value)
    }
    
    func expandSubjectExpenceCell(value: Bool) {
        output.displayExpandedSubjectCell(value)
    }
    
    // MARK: Lazy
    
    lazy var dateFormatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .NoStyle
        return dateFormatter
    }()
    
    
    lazy var numberFormatter: NSNumberFormatter = {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        return formatter
    }()

}
