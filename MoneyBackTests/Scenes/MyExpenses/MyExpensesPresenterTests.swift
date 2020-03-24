//
//  MyExpensesPresenterTests.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 4/13/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

@testable import MoneyBack
import XCTest

class MyExpensesPresenterTests: XCTestCase {

    // MARK: Subject under test

    var sut: MyExpensesPresenter!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupMyExpensesPresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup

    func setupMyExpensesPresenter() {
        sut = MyExpensesPresenter()
    }

    // MARK: Test doubles

    class MyExpensesPresenterOutputSpy: MyExpensesPresenterOutput {
        
        // MARK: Method call expectations
        var displayExpensesCalled = false
        var displaySuccessMessageCalled = false
        var displayErrorMessageCalled = false
        
        // MARK: Argument expectations
        var myExpensesViewModel: MyExpensesViewModel!
        
        // MARK: Spied methods
        func displayExpenses(viewModel: MyExpensesViewModel) {
            displayExpensesCalled = true
            myExpensesViewModel = viewModel
        }

        func displaySuccessMessage(message: String) {
            displaySuccessMessageCalled = true
        }
        
        func displayErrorMessage(message: String) {
            displayErrorMessageCalled = true
        }
    }
    
    // MARK: Tests

    func testPresentMyExpensesShouldFormatExpensesForDisplay() {
        
        // Given
        let myExpensesPresenterOutputSpy = MyExpensesPresenterOutputSpy()
        sut.output = myExpensesPresenterOutputSpy
        
        let dateComponents = NSDateComponents()
        dateComponents.year = 2007
        dateComponents.month = 6
        dateComponents.day = 29
        let date = NSCalendar.currentCalendar().dateFromComponents(dateComponents)!
        
        let expense = Expense()
        expense.ticketNumber = "xxx"
        expense.date = date
        expense.amount = 10
        
        let response = MyExpensesResponse(expenses: [expense])
        
        // When
        sut.presentExpense(response)
        
        // Then
        let displayedExpenses = myExpensesPresenterOutputSpy.myExpensesViewModel.displayedExpenses
        for displayedExpense in displayedExpenses {
            XCTAssertEqual(displayedExpense.ticketNumber, "xxx", "Presenting fetched expense should properly format order ID")
            XCTAssertEqual(displayedExpense.date, "6/29/07", "Presenting fetched expense should properly format order date")
            XCTAssertEqual(displayedExpense.amount, "$ 10.0", "Presenting fetched expense should properly format email")
        }
    }
    
    func testPresentMyExpensesShouldAskViewControllerToDisplayExpenses() {
        
        // Given
        let myExpensesPresenterOutputSpy = MyExpensesPresenterOutputSpy()
        sut.output = myExpensesPresenterOutputSpy
        
        let expense = Expense()
        expense.ticketNumber = "xxx"
        expense.date = NSDate()
        expense.amount = 10
        
        let response = MyExpensesResponse(expenses: [expense])
        
        // When
        sut.presentExpense(response)
        
        // Then
        XCTAssert(myExpensesPresenterOutputSpy.displayExpensesCalled, "Presenting fetched expenses should ask view controller to display them")
    }
    
    func testPresentMyExpensesShouldDisplayASuccessMessage() {
        
        // Given
        let myExpensesPresenterOutputSpy = MyExpensesPresenterOutputSpy()
        sut.output = myExpensesPresenterOutputSpy
        
        // When
        sut.presentExpenseSuccess(true)
        
        // Then
        XCTAssert(myExpensesPresenterOutputSpy.displaySuccessMessageCalled, "Presenting a success messages")
        XCTAssertFalse(myExpensesPresenterOutputSpy.displayErrorMessageCalled, "Presenting a success messages")
    }
    
    func testPresentMyExpensesShouldDisplayAnErrorMessage() {
        
        // Given
        let myExpensesPresenterOutputSpy = MyExpensesPresenterOutputSpy()
        sut.output = myExpensesPresenterOutputSpy
        
        // When
        sut.presentExpenseSuccess(false)
        
        // Then
        XCTAssert(myExpensesPresenterOutputSpy.displayErrorMessageCalled, "Presenting a success messages")
        XCTAssertFalse(myExpensesPresenterOutputSpy.displaySuccessMessageCalled, "Presenting a success messages")
    }
}
