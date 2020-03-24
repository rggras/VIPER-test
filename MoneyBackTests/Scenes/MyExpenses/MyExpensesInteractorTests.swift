//
//  MyExpensesInteractorTests.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 4/13/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

@testable import MoneyBack
import XCTest

class MyExpensesInteractorTests: XCTestCase {

    // MARK: Subject under test

    var sut: MyExpensesInteractor!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupMyExpensesInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup

    func setupMyExpensesInteractor() {
        sut = MyExpensesInteractor()
    }

    // MARK: Test doubles

    class MyExpensesInteractorOutputSpy: MyExpensesInteractorOutput {
        
        // MARK: Method call expectations
        var presentExpenseCalled = false
        var presentExpenseSuccessCalled = false
        
        // MARK: Spied methods
        func presentExpense(response: MyExpensesResponse) {
            presentExpenseCalled = true
        }
        
        func presentExpenseSuccess(success: Bool) {
            presentExpenseSuccessCalled = true
        }
    }
    
    class MyExpensesWorkerSpy: MyExpensesWorker {
        
        // MARK: Method call expectations
        var getExpensesCalled = false
        var saveExpenseCalled = false
        
        // MARK: Spied methods
        override func getExpenses(success: [Expense] -> Void) {
            getExpensesCalled = true
            success([])
        }
        
        override func addExpense(expenseData: Expense, success: Bool -> Void) {
            saveExpenseCalled = true
        }
    }
    
    class ExpenseRepositorySpy: ExpenseRepository {
        var getExpensesCalled = false
        
        override func getExpenses(success: [Expense] -> Void) {
            getExpensesCalled = true
        }
    }
    
    // MARK: Tests

    func testFetchOrdersShouldAskOrdersWorkerToFetchOrders() {
        
        // Given
        let expenseRepositorySpy = ExpenseRepositorySpy()
        sut.repository = expenseRepositorySpy
        
        // When
        sut.getExpenses()
        
        // Then
        XCTAssert(expenseRepositorySpy.getExpensesCalled, "getExpenses() should ask MyExpensesWorkerSpy to get expenses")
    }
    
    // asdasdasd
    func testAddNewExpenseAndPresenterToFormatResult() {
        
        // Given
        let myExpensesInteractorOutputSpy = MyExpensesInteractorOutputSpy()
        sut.output = myExpensesInteractorOutputSpy
        let myExpensesWorkerSpy = MyExpensesWorkerSpy()
        let expenseRepositorySpy = ExpenseRepositorySpy()
        sut.worker = myExpensesWorkerSpy
        sut.repository = expenseRepositorySpy
        
        // When
        sut.worker.addExpense(Expense()) { (success) in
            // Then
            XCTAssertTrue(success)
            XCTAssert(myExpensesInteractorOutputSpy.presentExpenseSuccessCalled, "addExpense() should ask presenter to format expenses result")
        }
    }
    
    // asdasdasd 123456
    func testGetExpensesAndPresenterToFormatResult() {
        
        // Given
        let myExpensesInteractorOutputSpy = MyExpensesInteractorOutputSpy()
        sut.output = myExpensesInteractorOutputSpy
        let myExpensesWorkerSpy = MyExpensesWorkerSpy()
        let expenseRepositorySpy = ExpenseRepositorySpy()
        sut.worker = myExpensesWorkerSpy
        sut.repository = expenseRepositorySpy
        
        // When
        sut.repository.getExpenses { (expense: [Expense]) in
            // Then
            XCTAssertNotNil(expense)
            XCTAssert(myExpensesInteractorOutputSpy.presentExpenseCalled, "getExpenses() should ask presenter to format expenses result")
        }
    }
    
    func testAddNewExpense() {
        // Given
        let myExpensesInteractorOutputSpy = MyExpensesInteractorOutputSpy()
        sut.output = myExpensesInteractorOutputSpy
        let myExpensesWorkerSpy = MyExpensesWorkerSpy()
        sut.worker = myExpensesWorkerSpy
        
        // When
        let newExpense = MyExpensesViewModel.DisplayedExpense(ticketNumber: "123456", date: "10/10/10", status: "ready", amount: "$ 40", projectName: "Test", subject: "test", coin: "pesos")
        sut.addExpense(newExpense)
        
        // Then
        XCTAssert(myExpensesWorkerSpy.saveExpenseCalled, "saveExpense() should save a new expense")
    }
}
